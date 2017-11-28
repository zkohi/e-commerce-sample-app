class Users::RegistrationsController < Devise::RegistrationsController
  def after_update_path_for(resource)
    mypage_path
  end
end
