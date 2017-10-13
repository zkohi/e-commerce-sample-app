class UserPointsController < Users::ApplicationController
  before_action :set_coupon, only: [:edit, :update]

  def points
    @user_points = UserPoint.page(params[:page])
  end

  def index
    @coupons = Coupon.page(params[:page])
  end

  def edit
  end

  def create
    @user_point = current_user.user_points.build(user_points_params)
    @user_point.status = "coupon"
    @user_point.point = @user_point.coupon.point

    if @user_point.save
      redirect_to points_path, notice: 'クーポンを使用しました'
    else
      redirect_to @user_point.coupon, notice: 'クーポンを使用できませんでした'
    end
  end

  def update
    if @user_point.update(user_coupon_params)
      redirect_to @user_point, notice: 'User coupon was successfully updated.'
    else
      render :edit
    end
  end

  private
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    def user_points_params
      params.require(:user_point).permit(:coupon_id)
    end
end
