class PasswordsContract < ApplicationContract
  params do
    required(:password).filled(:string)
    required(:password_confirmation).filled(:string)
  end

  rule(:password).validate(:password)

  rule(:password, :password_confirmation) do
    unless values[:password] == values[:password_confirmation]
      key.failure(I18n.t('errors.password_confirmation_unmatched'))
    end
  end
end
