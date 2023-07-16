class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_admin!, if: :admin_url

  def admin_url
    request.fullpath.include?("/admin")
  end

  private

  def after_sign_in_path_for(resource)
    customer_path(resource)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email,])
  end
end
