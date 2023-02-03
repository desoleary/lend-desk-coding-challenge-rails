require 'rails_helper'

describe PasswordEncryptor do
  describe '.encrypt' do
    let(:password) { 'secret' }

    subject { described_class.encrypt(password) }

    it 'returns encrypted password hash' do
      expect(subject.length).to eql(60)
    end
  end

  describe '.secure_compare?' do
    let(:password) { 'secret' }
    let(:other_password) { 'secret' }
    let(:encrypted_password) { described_class.encrypt(password) }

    subject { described_class.secure_compare?(other_password, encrypted_password) }

    context 'with matching password' do
      it 'returns true' do
        expect(subject).to be_truthy
      end
    end

    context 'with unmatched password' do
      let(:other_password) { 'other-secret' }

      it 'returns false' do
        expect(subject).to be_falsey
      end
    end

    describe '.cost' do
      it 'sets cost to test cost' do
        expect(described_class.cost).to eql(TEST_ENCRYPTOR_COST)
      end

      context 'with cost unset' do
        around(:each) do |example|
          original_cost = described_class.cost
          described_class.cost = nil

          example.run

          described_class.cost = original_cost
        end

        it 'sets cost to BCrypt default' do
          expect(described_class.cost).to eql(12)
        end
      end
    end
  end
end
