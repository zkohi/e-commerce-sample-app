class Users::ApplicationController < ApplicationController
  before_action :authenticate_user!

  private
    def set_user_point_total
      @user_point_total = current_user.user_points.total.first
    end
end
