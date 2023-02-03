# frozen_string_literal: true

require 'rails_helper'

describe ApplicationContract do
  describe 'Registered Macros' do
    describe 'password' do
      let(:contract_class) do
        Class.new(ApplicationContract) do
          params do
            required(:password).maybe(:string)
          end

          rule(:password).validate(:password)
        end
      end

      let(:password) { nil }
      let(:params) { { password: password } }

      subject { contract_class.new.call(params) }

      context 'with valid password' do
        let(:password) { 'aA9^efgh' }

        it 'returns success' do
          expect(subject.success?).to be_truthy
        end
      end

      context 'with invalid password' do
        let(:password) { '' }

        it 'returns error messages' do
          expect(subject.success?).to be_falsey

          errors = subject.errors.to_h
          expect(errors.keys).to match_array([:password])

          error_messages = errors[:password]
          expect(error_messages).to match_array([
                                                  'must be at least 8 characters long',
                                                  'must contain at least 1 lowercase letter',
                                                  'must contain at least 1 number',
                                                  'must contain at least 1 symbols',
                                                  'must contain at least 1 uppercase letter'
                                                ])
        end
      end
    end
  end
end
