module RedisStore
  class NotConnected < StandardError; end

  class Entry < Dry::Struct
    include Helpers::CoreCommands
    extend Helpers::Serializer

    attribute :key, Types::String

    class << self
      def find(key)
        serialized_value = self.redis.get(key)
        return if serialized_value.nil?

        value = deserialize_value(serialized_value)

        new(key: key, **value)
      end
    end

    def save
      write(attributes.except(:key))
    end


    def redis
      self.class.redis
    end

    class << self
      def redis=(conn)
        @redis = ConnectionPoolProxy.proxy_if_needed(conn)
      end

      def redis
        @redis || raise(NotConnected, 'User.redis not set to a Redis.new connection pool')
      end
    end
  end
end
