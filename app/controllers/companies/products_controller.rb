class Companies::ProductsController < Companies::ApplicationController
  before_action :set_product_stock, only: [:create, :destroy]

  def index
    @products = Product.all.page(params[:page])
  end

  def stocks
    @product_stocks = current_company.product_stocks.order(updated_at: :desc).all.page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
    @product_stock = current_company.product_stocks.find_or_initialize_by(product_id: params[:id])
  end

  def create
    @product_stock.stock = product_stock_params[:stock]
    if @product_stock.save
      message = '商品在庫が登録されました'
    else
      message = '商品在庫が登録されませんでした'
    end
    redirect_to companies_product_path(@product_stock.product_id), notice: message
  end

  def destroy
    @product_stock.destroy
    redirect_to companies_stocks_url, notice: '商品在庫が削除されました'
  end

  private
    def set_product_stock
      @product_stock = current_company.product_stocks.find_or_initialize_by(product_id: params[:product_id])
    end

    def product_stock_params
      params.require(:product_stock).permit(:stock)
    end
end
