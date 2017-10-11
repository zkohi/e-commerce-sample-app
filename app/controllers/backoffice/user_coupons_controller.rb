class Backoffice::UserCouponsController < Backoffice::ApplicationController
  def index
    @user_coupons = UserCoupon.all.page(params[:page])
  end

  def show
    @user_coupon = UserCoupon.find(params[:id])
  end
end
