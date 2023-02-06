class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception # helps protects against CSRF
end
