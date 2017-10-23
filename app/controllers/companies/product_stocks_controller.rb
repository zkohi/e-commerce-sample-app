class Companies::ProductStocksController < Companies::ApplicationController
  def index
    @products = current_company.product_stocks.all.page(params[:page])
  end

  def create
    @product_stock = current_company.product_stocks.find_or_initialize_by(product_stock_params)

    if @product_stock.save
      message = '商品在庫が登録されました'
    else
      message = '商品在庫が登録されませんでした'
    end
    redirect_to companies_product_path(@product_stock.product_id), notice: message
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_stock_params
      params.require(:product_stock).permit(:stock).merge(product_id: params[:product_id])
    end
end
