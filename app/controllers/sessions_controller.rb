class SessionsController < ApplicationController
  SESSION_STATE_KEY = :secure_session

  def create
    ctx = UserAuthOrganizer.call(user_params.to_h)
    return render_unauthorized_error(ctx.errors) if ctx.failure?

    ctx = LoginSessionCreateOrganizer.call(ctx.params.slice(:user_id))
    return render_unauthorized_error(ctx.errors) if ctx.failure?

    login_state = ctx.params[:login_state]
    cookies[SESSION_STATE_KEY] = {
      expires: Time.at(login_state[:expires_at]),
      secure: Rails.configuration.force_ssl,
      domain: :all,
      httponly: true,
      value: Encryptor.encrypt({ last_request_at: Time.current.to_i }.merge(login_state))
    }

    render_created(ctx.params.slice(:user_id))
  end

  private

  def user_params
    params.permit(:email, :password)
  end

  def session_cookie
    cookies[SESSION_STATE_KEY]
  end
end
