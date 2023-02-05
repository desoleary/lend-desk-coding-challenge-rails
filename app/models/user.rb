# frozen_string_literal: true

class User < ApplicationEntry
  # authenticatable
  attribute :email, Types::String.optional
  attribute :password, Types::String.optional
  attribute :password_confirmation, Types::String.optional

  class << self
    def create(email:, password:, password_confirmation:)
      new(key: email, email: email, password: password, password_confirmation: password_confirmation).save
    end
  end
end
