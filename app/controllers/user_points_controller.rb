class UserPointsController < Users::ApplicationController
  before_action :used_coupon?, only: [:create]
  before_action :set_user_point_total, only: [:index]

  def index
    @user_points = current_user.user_points.where.not(status: :total).page(params[:page])
  end

  def create
    @user_point = current_user.user_points.build(user_points_params)
    @user_point.status = "coupon"
    @user_point.point = @user_point.coupon.point

    if @user_point.save
      redirect_to points_path, notice: 'クーポンを使用しました'
    else
      redirect_to coupon_path(@user_point.coupon_id), notice: 'クーポンを使用できませんでした'
    end
  end

  private
    def used_coupon?
      if current_user.user_points.where(coupon_id: user_points_params[:coupon_id]).exists?
        redirect_to coupon_path(user_points_params[:coupon_id]), notice: 'クーポンは使用済みです'
      end
    end

    def user_points_params
      params.require(:user_point).permit(:coupon_id)
    end
end
