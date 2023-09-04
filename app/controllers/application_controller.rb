class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def current_user
    User.find_by(id: current_api_v1_user.id) if current_api_v1_user
  end

  def current_user_admin?
    return current_user.is_admin if current_user
  end
end
