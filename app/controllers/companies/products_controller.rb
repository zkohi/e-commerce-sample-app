class Companies::ProductsController < Companies::ApplicationController

  def index
    @products = Product.all.page(params[:page])
  end

  def stocks
    @product_stocks = current_company.product_stocks.all.page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
    @product_stock = current_company.product_stocks.find_or_initialize_by(product_id: params[:id])
  end

  def create
    @product_stock = current_company.product_stocks.find_or_initialize_by(product_id: params[:product_id])
    @product_stock.stock = product_stock_params[:stock]
    if @product_stock.save
      redirect_to companies_stocks_path, notice: '商品在庫が登録されました'
    else
      redirect_to companies_product_path(@product_stock.product_id), notice: '商品在庫が登録されませんでした'
    end
  end

  private
    def product_stock_params
      params.require(:product_stock).permit(:stock)
    end
end
