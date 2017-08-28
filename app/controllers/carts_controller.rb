class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @order = current_user.orders.find_or_initialize_by(state: :cart)
  end

  def edit
    @order = current_user.orders.find_or_initialize_by(state: :cart)
    if @order.line_items.empty?
      redirect_to cart_path
    end
  end

  def update
    @order = current_user.orders.cart.first
    #if @order
    #  @order.update
    #  redirect_to @order, notice: 'ご注文完了しました'
    #else
    #  redirect_to cart_path
    #end

    if @order && @order.execute(order_params)
      redirect_to @order, notice: 'ご注文完了しました'
    else
      render :edit
    end
  end

  private
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
