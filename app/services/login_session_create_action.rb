class LoginSessionCreateAction < ApplicationAction
  expects :params

  executed do |ctx|
    existing_user = User.find(ctx.dig(:params, :user_id))
    user_id = existing_user&.id

    add_errors(ctx, user_id: I18n.t('errors.not_found')) if user_id.nil?

    session = LoginSession.create(user_id: user_id)
    encrypted_login_state = Encryptor.encrypt(
      user_id: user_id,
      session_id: session.id,
      initiated_at: Time.current.to_i,
      expires_at: Time.current.to_i + LoginSession::EXPIRES_IN_SECONDS
    )

    add_params(ctx, login_state: encrypted_login_state)
  end
end
