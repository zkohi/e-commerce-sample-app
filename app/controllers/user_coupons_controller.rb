class UserCouponsController < ApplicationController
  before_action :set_user_coupon, only: [:edit, :update]

  def index
    @coupons = Coupon.page(params[:page])
  end

  def show
  end

  def new
    @user_coupon = UserCoupon.new
  end

  def edit
  end

  def create
    @user_coupon = UserCoupon.new(coupon_params)

    if @user_coupon.save
      redirect_to @coupon, notice: 'User coupon was successfully created.'
    else
      render :new
    end
  end

  def update
    if @user_coupon.update(coupon_params)
      redirect_to @coupon, notice: 'User coupon was successfully updated.'
    else
      render :edit
    end
  end

  private
    def set_user_coupon
      @user_coupon = UserCoupon.find(params[:id])
    end

    def user_coupon_params
      params.require(:coupon).permit(:id, :coupon_id, :point)
    end
end
