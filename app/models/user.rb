# frozen_string_literal: true

class User < ApplicationEntry
  attribute :password, Types::String.optional
end
