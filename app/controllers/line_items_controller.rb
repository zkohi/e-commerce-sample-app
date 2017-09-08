class LineItemsController < ApplicationController
  before_action :set_order, only: [:destroy]
  before_action :set_line_item, only: [:destroy]

  def destroy
    @line_item.destroy
    @order.update_for_delete_line_item!
    redirect_to cart_path, notice: '商品が削除されました'
  end

  private
    def set_order
      @order = current_user.orders.cart.first
    end

    def set_line_item
      @line_item = @order.line_items.find(params[:id])
    end
end
