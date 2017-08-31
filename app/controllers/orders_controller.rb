class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show]

  def index
    @orders = current_user.orders.ordered.page(params[:page])
  end

  def show
  end

  def create
    line_item = order_params[:line_items_attributes]["0"]
    if line_item["quantity"].present?
      @order = current_user.orders.find_or_initialize_by(state: :cart)
      @order.line_items.build(line_item)

      @order.save_for_add_line_item!(order_params)
      redirect_to cart_path
    else
      redirect_to product_path(line_item["product_id"]), notice: '個数を入力してください'
    end
  end

  private
    def set_order
      @order = current_user.orders.ordered.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:id, line_items_attributes: [:product_id, :quantity])
    end
end
