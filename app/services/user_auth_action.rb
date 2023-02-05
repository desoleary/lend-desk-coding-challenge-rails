class UserAuthAction < ApplicationAction
  expects :params

  executed do |ctx|
    user = User.find(ctx.dig(:params, :email))
    add_params(ctx, user_id: user&.key)

    if user.nil?
      add_errors(ctx, email: I18n.t('errors.not_found'))
      ctx.fail_and_return!
    end

    password = ctx.dig(:params, :password)
    encrypted_password = user&.password
    unless PasswordEncryptor.secure_compare?(password, encrypted_password)
      add_errors(ctx, email: I18n.t('errors.invalid_credentials'))
      ctx.fail_and_return!
    end
  end
end
