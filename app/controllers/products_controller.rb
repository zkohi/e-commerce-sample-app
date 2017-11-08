class ProductsController < Users::ApplicationController
  def index
    @products = Product.display.page(params[:page]).order(sort_order: :desc)
  end

  def show
    @product = Product.display.find(params[:id])
  end
end
