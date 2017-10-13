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
        "backoffice"
      else
        "application"
      end
    end

    def after_sign_in_path_for(resource)
      case resource.class
        when Admin
          backoffice_products_path
        when Company
          companies_product_stocks_path
        else
          root_path
        end
    end

    def after_sign_out_path_for(resource_name)
      case resource_name
        when :admin
          new_admin_session_path
        when :company
          new_company_session_path
        else
          new_user_session_path
        end
    end
end
