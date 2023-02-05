# frozen_string_literal: true

class User < ApplicationEntry
  # authenticatable
  attribute :email, Types::String.optional
  attribute :password, Types::String.optional
  attribute :password_confirmation, Types::String.optional

  class << self
    def create(email:, password:, password_confirmation:)
      attrs = { email: email,
                password: PasswordEncryptor.encrypt(password),
                password_confirmation: PasswordEncryptor.encrypt(password_confirmation) }

      new(key: email, **attrs).save
    end
  end
end
