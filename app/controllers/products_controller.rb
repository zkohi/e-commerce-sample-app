class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.order("sort_order DESC").where(flg_non_display: false)
  end

  def show
    @product = Product.find(params[:id])
    @order = Order.new
    @order.line_items.build
  end
end
