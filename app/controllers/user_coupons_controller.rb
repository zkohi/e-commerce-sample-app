class UserCouponsController < ApplicationController
  before_action :set_user_coupon, only: [:show, :edit, :update, :destroy]

  def index
    @user_coupons = UserCoupon.all
  end

  def show
  end

  def new
    @user_coupon = UserCoupon.new
  end

  def edit
  end

  def create
    @user_coupon = UserCoupon.new(user_coupon_params)

    if @user_coupon.save
      redirect_to @user_coupon, notice: 'User coupon was successfully created.'
    else
      render :new
    end
  end

  def update
    if @user_coupon.update(user_coupon_params)
      redirect_to @user_coupon, notice: 'User coupon was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user_coupon.destroy
    redirect_to user_coupons_url, notice: 'User coupon was successfully destroyed.'
  end

  private
    def set_user_coupon
      @user_coupon = UserCoupon.find(params[:id])
    end

    def user_coupon_params
      params.require(:user_coupon).permit(:user_id, :coupon_id, :point)
    end
end
