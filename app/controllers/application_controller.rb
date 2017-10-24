class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters

  protect_from_forgery with: :exception

  layout :layout_by_resource

  protected

    def configure_permitted_parameters
      if devise_controller? && resource_name != :company
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :zipcode, :address, :nickname, :img_filename])
      end
    end

  private

    def layout_by_resource
      if devise_controller? && resource_name == :admin
        "backoffice"
      else
        "application"
      end
    end

    def after_sign_in_path_for(resource)
      if resource.class == Admin
        backoffice_products_path
      elsif resource.class == Company
        companies_stocks_path
      else
        root_path
      end
    end

    def after_sign_out_path_for(resource_name)
      if resource_name == :admin
        new_admin_session_path
      elsif resource_name == :company
        new_company_session_path
      else
        new_user_session_path
      end
    end
end
