class LineItemsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    current_user.orders.cart.first.update_for_delete_line_item!(params[:id])
    redirect_to cart_path, notice: '商品が削除されました'
  end
end
