class LineItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:destroy]
  before_action :set_line_item, only: [:destroy]

  def destroy
    @order = current_user.orders.cart.first
    @order.line_items.find(params[:id]).destroy
    @order.update_for_delete_line_item!
    redirect_to cart_path, notice: '商品が削除されました'
  end
end
