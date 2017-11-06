class CouponsController < Users::ApplicationController
  before_action :set_coupon, only: [:show]
  before_action :used_coupon?, only: [:create]

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
