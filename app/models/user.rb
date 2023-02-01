# frozen_string_literal: true

class User < RedisStore::Entry
  attribute :password, Types::String.optional
end
