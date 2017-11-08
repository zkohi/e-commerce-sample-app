class Companies::RegistrationsController < Devise::RegistrationsController
  def after_update_path_for(resource)
    companies_stocks_path
  end
end
