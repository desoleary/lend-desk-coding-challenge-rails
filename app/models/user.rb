# frozen_string_literal: true

class User < ApplicationEntry
  # authenticatable
  attribute :encrypted_password, Types::String.optional

  alias email key
end
