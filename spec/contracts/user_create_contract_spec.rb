require 'rails_helper'

describe UserCreateContract, type: :dry_validation do
  let(:email) { 'email@domain.com' }
  let(:password) { 'aA9^efgh' }
  let(:password_confirmation) { 'aA9^efgh' }
  let(:params) { { email: email, password: password, password_confirmation: password_confirmation } }

  let(:contract_results) { described_class.new.call(params) }

  it 'returns success' do
    expect(contract_results.success?).to be_truthy
  end

  describe 'email' do
    it { is_expected.to validate(:email, :optional).macro_use?(:email) }
  end

  describe 'password_confirmation' do
    context 'with password not matching password confirmation' do
      let(:password_confirmation) { 'other-secret' }

      it 'returns failure' do
        expect(contract_results.failure?).to be_truthy

        errors = contract_results.errors.to_h
        expect(errors.keys).to match_array([:password])

        expect(errors[:password]).to match_array(["password must match password confirmation"])
      end
    end
  end
end
