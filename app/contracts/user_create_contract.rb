class UserCreateContract < ApplicationContract
  params do
    required(:email).maybe(:string)
  end

  rule(:email).validate(:email)

  def call(input, context = {}.freeze)
    inner_contract = PasswordsContract.new.call(input)
    return inner_contract if inner_contract.failure?

    super
  end
end
