class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :edit]

  def show
  end

  def edit
    if @order.line_items.empty?
      redirect_to cart_path
    end
  end

  def update
    @order = current_user.orders.cart.first

    if @order && @order.order(order_params)
      redirect_to @order, notice: 'ご注文完了しました'
    else
      render :edit
    end
  end

  private
    def set_order
      @order = current_user.orders.find_or_initialize_by(state: :cart)
    end

    def order_params
      params.require(:order).permit(
        :id,
        :item_count,
        :item_total,
        :shipment_total,
        :payment_total,
        :adjustment_total,
        :tax_total,
        :total,
        :shipping_date,
        :shipping_time_range,
        :user_name,
        :user_zipcode,
        :user_address,
        line_items_attributes: [
          :id,
          :product_id,
          :quantity,
          :price
        ]
      )
    end
end
