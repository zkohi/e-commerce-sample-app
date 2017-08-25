class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @order = current_user.orders.find_or_initialize_by(state: :cart)
  end

  def edit
    @order = current_user.orders.find_or_initialize_by(state: :cart)
    if @order.line_items.blank?
      redirect_to cart_path
    end
  end

  def update
    @order = current_user.orders.find_or_initialize_by(state: :cart)
    if @order.line_items.blank?
      redirect_to cart_path
    end
    @order.line_items.build(order_params[:line_items_attributes]["0"])

    @order.save!
    redirect_to cart_orders_path, notice: 'Order was successfully created.'
  end

  private
    def order_params
      params.require(:order).permit(:id, line_items_attributes: [:product_id, :quantity])
    end
end
