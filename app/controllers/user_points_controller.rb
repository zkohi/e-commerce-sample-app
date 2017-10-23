class UserPointsController < Users::ApplicationController
  before_action :set_coupon, only: [:show]
  before_action :used_coupon?, only: [:create]

  def points
    @user_points = UserPoint.page(params[:page])
  end

  def index
    @coupons = Coupon.page(params[:page])
  end

  def show
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
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    def used_coupon?
      if current_user.user_points.where(coupon_id: user_points_params[:coupon_id]).exists?
        redirect_to coupon_path(user_points_params[:coupon_id]), notice: 'クーポンは使用済みです'
      end
    end

    def user_points_params
      params.require(:user_point).permit(:coupon_id)
    end
end
