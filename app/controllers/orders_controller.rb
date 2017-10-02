class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:cart, :edit]

  def index
    @orders = current_user.orders.ordered.page(params[:page])
  end

  def show
    @order = current_user.orders.ordered.find(params[:id])
  end

  def create
    line_item = order_lineitem_params[:line_items_attributes]["0"]
    if line_item["quantity"].present?
      @order = current_user.orders.find_or_initialize_by(state: :cart)

      @order.save_for_add_line_item!(order_lineitem_params)
      redirect_to cart_path
    else
      redirect_to product_path(line_item["product_id"]), notice: '個数を入力してください'
    end
  end

  def cart
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

  def destroy_cart_line_item
    current_user.orders.cart.first.update_for_delete_line_item!(params[:line_item_id])
    redirect_to cart_path, notice: '商品が削除されました'
  end

  private
    def set_order
      @order = current_user.orders.find_or_initialize_by(state: :cart)
    end

    def order_lineitem_params
      params.require(:order).permit(:id, line_items_attributes: [:product_id, :quantity])
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
