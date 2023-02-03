module PasswordEncryptor
  class << self
    attr_writer :cost

    def encrypt(password)
      BCrypt::Password.create(password)
    end

    def secure_compare?(password, encrypted_password)
      BCrypt::Password.new(encrypted_password) == password
    end

    def cost
      @cost ||= BCrypt::Engine.cost
    end
  end
end
