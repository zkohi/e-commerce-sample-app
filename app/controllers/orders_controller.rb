class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :update]

  def index
    @orders = current_user.orders.all
  end

  def show
  end

  def create
    @order = current_user.orders.find_or_initialize_by(state: :cart)
    @order.line_items.build(order_params[:line_items_attributes]["0"])

    @order.save!
    redirect_to cart_path, notice: 'Order was successfully created.'
  end

  private
    def set_order
      @order = current_user.orders.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:id, line_items_attributes: [:product_id, :quantity])
    end
end
