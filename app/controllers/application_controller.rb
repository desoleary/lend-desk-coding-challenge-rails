class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception # helps protects against CSRF

  protected

  def render_unauthorized_error(error_messages)
    render json: { errors: error_messages }, status: 401
  end

  def render_success(params = {})
    render json: params, status: 200
  end

  def render_created(params = {})
    render json: params, status: 201
  end
end
