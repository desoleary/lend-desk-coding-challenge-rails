require 'rails_helper'

describe RedisStore::Entry do
  let(:subject_class) do
    Class.new(RedisStore::Entry) do
      def self.redis
        @redis ||= MockRedis.new
      end

      attribute :password, Types::String.optional
    end
  end

  let(:key) { 'some-key' }
  let(:attributes) { { password: 'some-password' }}
  let(:instance) { subject_class.new(key: 'desoleary@gmail.com', **attributes) }

  let(:subject) do
    instance.save
  end

  describe '.new' do
    it 'initializes instance' do
      instance = subject_class.new(key: key, **attributes)

      expect(instance.key).to eql(key)
      expect(instance.read).to be_nil
    end
  end

  describe '.save' do
    it 'initializes instance' do
      instance.save

      expect(instance.read).to eql(attributes)
    end
  end

  describe '.create' do
    it 'stores record' do
      actual = subject_class.create(key: key, **attributes)

      expect(actual.key).to eql(key)

      entry = subject_class.find(key)
      expect(entry.attributes).to eql(attributes)
    end
  end

  describe '.find' do
    it 'stores hash data into redis store' do
      subject

      actual = subject_class.find('desoleary@gmail.com')
      expect(actual.attributes).to eql(attributes)
    end
  end
end
