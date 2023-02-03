# frozen_string_literal: true

class User < ApplicationEntry
  # authenticatable
  attribute :password, Types::String.optional

  alias email key

  class << self
    def create(email:, password:, password_confirmation:) end
  end
end
