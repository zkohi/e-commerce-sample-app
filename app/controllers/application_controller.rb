class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters

  protect_from_forgery with: :exception

  layout :layout_by_resource

  protected

  def configure_permitted_parameters
    if devise_controller? && resource_name != :admin
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :zipcode, :address])
    end
  end

  private

  def layout_by_resource
    if devise_controller? && resource_name == :admin
      "admin"
    else
      "application"
    end
  end

  def after_sign_in_path_for(resource)
    if resource.class == Admin
      admin_products_path
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource_name)
    if resource_name == :admin
      new_admin_session_path
    else
      new_user_session_path
    end
  end
end
