# frozen_string_literal: true

module RedisStore
  module Helpers
    module Serializer
      def serialize_value(value)
        return value if value.nil?

        MessagePack.pack(value)
      end

      def deserialize_value(value)
        return if value.nil?

        MessagePack.unpack(value).deep_symbolize_keys
      end
    end

    module CoreCommands
      include Serializer

      def exists
        redis.exists key
      end

      def exists?
        redis.exists? key
      end

      # Delete key. Redis: DEL
      def delete
        redis.del key
      end
      alias del delete
      alias clear delete

      def expire(seconds)
        redis.expire key, seconds
      end

      def ttl
        redis.ttl(key)
      end

      def read
        find key
      end

      def write(value)
        redis.set key, serialize_value(value)
      end
    end
  end
end
