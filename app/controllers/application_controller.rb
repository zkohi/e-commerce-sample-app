class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

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
    if resource_name == :admin
      "admin"
    else
      "application"
    end
  end
end
