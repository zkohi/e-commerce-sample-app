class CouponUsersController < ApplicationController
  before_action :set_coupon_user, only: [:show, :edit, :update, :destroy]

  def index
    @coupon_users = CouponUser.all
  end

  def show
  end

  def new
    @coupon_user = CouponUser.new
  end

  def edit
  end

  def create
    @coupon_user = CouponUser.new(coupon_user_params)

    if @coupon_user.save
      redirect_to @coupon_user, notice: 'Coupon user was successfully created.'
    else
      render :new
    end
  end

  def update
    if @coupon_user.update(coupon_user_params)
      redirect_to @coupon_user, notice: 'Coupon user was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @coupon_user.destroy
    redirect_to coupon_users_url, notice: 'Coupon user was successfully destroyed.'
  end

  private
    def set_coupon_user
      @coupon_user = CouponUser.find(params[:id])
    end

    def coupon_user_params
      params.require(:coupon_user).permit(:coupon_id, :user_id, :point)
    end
end
