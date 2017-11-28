class CouponsController < Users::ApplicationController
  before_action :set_coupon, only: [:show]

  def index
    @coupons = Coupon.page(params[:page])
  end

  def show
  end

  private

    def set_coupon
      @coupon = Coupon.find(params[:id])
    end
end
