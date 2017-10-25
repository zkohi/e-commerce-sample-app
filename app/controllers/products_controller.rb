class ProductsController < Users::ApplicationController
  def index
    @products = Product.display.page(params[:page]).order(sort_order: :desc)
  end

  def show
    @product = Product.display.find(params[:id])
    @companies = Company.includes(:product_stocks).where("product_stocks.product_id": params[:id]).all
  end
end
