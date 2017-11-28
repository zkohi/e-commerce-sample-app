class UsersController < Users::ApplicationController
  def show
    @diaries = current_user.diaries.order(created_at: :desc).page(params[:page])
  end
end
