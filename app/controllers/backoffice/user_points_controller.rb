class Backoffice::UserPointsController < Backoffice::ApplicationController
  before_action :set_user, only: [:new, :create]

  def index
    @user_points = UserPoint.all.page(params[:page])
  end

  def new
    @user_point = UserPoint.new
  end

  def create
    @user_point = UserPoint.new(user_points_params)
    @user_point.status = "admin"

    if @user_point.save
      redirect_to backoffice_user_path(@user_point.user_id), notice: 'ポイントを登録しました'
    else
      redirect_to new_backoffice_user_point_path(@user_point.user_id), notice: 'ポイントを登録できませんでした'
    end
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

    def user_points_params
      params.require(:user_point).permit(:point).merge(user_id: params[:user_id])
    end
end
