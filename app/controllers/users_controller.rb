class UsersController < Users::ApplicationController
  before_action :set_user_point_total, only: [:show]

  def show
    @diaries = current_user.diaries.order(created_at: :desc).page(params[:page])
  end
end
