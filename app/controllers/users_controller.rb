class UsersController < Users::ApplicationController
  before_action :set_user_point_total, only: [:show]

  def show
  end
end
