class Backoffice::CouponsController < Backoffice::ApplicationController
  before_action :set_coupon, only: [:show, :edit, :update, :destroy]

  def index
    @coupons = Coupon.all.page(params[:page])
  end

  def show
  end

  def new
    @coupon = Coupon.new
  end

  def edit
  end

  def create
    @coupon = Coupon.new(coupon_params)

    if @coupon.save
      redirect_to [:backoffice, @coupon], notice: 'クーポンが作成されました'
    else
      render :new
    end
  end

  def update
    if @coupon.update(coupon_params)
      redirect_to [:backoffice, @coupon], notice: 'クーポンが更新されました'
    else
      render :edit
    end
  end

  def destroy
    @coupon.destroy
    redirect_to backoffice_coupons_url, notice: 'クーポンが削除されました'
  end

  private
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    def coupon_params
      params.require(:coupon).permit(:code, :point)
    end
end
