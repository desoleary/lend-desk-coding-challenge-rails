# frozen_string_literal: true

module RedisStore
  class NotConnected < StandardError; end

  class Entry < Dry::Struct
    include Helpers::CoreCommands
    extend Helpers::CoreCommands::ClassMethods

    attribute :key, Types::String

    class << self
      def new(key:, **attributes)
        attrs_with_defaults = fill_in_missing_keys(**attributes)
        super(key: key, **attrs_with_defaults)
      end

      def create(key:, **attributes)
        new(key: key, **attributes).save
      end

      def find(key)
        value = read_by(key)
        return if value.nil?

        new(key: key, **value)
      end

      def redis=(conn)
        @redis = ConnectionPoolProxy.proxy_if_needed(conn)
      end

      def redis
        @redis || raise(NotConnected, 'User.redis not set to a Redis.new connection pool')
      end

      private

      def fill_in_missing_keys(**attributes)
        keys = attribute_names - [:key]
        missing_keys = keys - attributes.keys
        return attributes if missing_keys.empty?

        missing_hash = Hash[missing_keys.map { |x| [x, nil] }]
        missing_hash.merge(attributes)
      end
    end

    def attributes
      super.except(:key)
    end

    def redis
      self.class.redis
    end

    def save
      set_hash(attributes.except(:key))

      self
    end
  end
end
