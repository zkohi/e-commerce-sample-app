class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.display.page(params[:page]).order("sort_order DESC")
  end

  def show
    @product = Product.display.find(params[:id])
  end
end
