class UserCreateAction < ApplicationAction
  expects :params

  executed do |ctx|
    attrs = ctx.dig(:params).slice(:email, :password, :password_confirmation)
    add_params(ctx, user_id: User.create(attrs).key)
  end
end
