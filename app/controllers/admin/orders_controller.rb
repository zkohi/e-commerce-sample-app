class Admin::OrdersController < Admin::ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  private
    def order_params
      params.require(:order).permit(:user_id, :state, :shipment_state, :payment_state, :item_count, :item_total, :shipment_total, :payment_total, :tax_total, :total)
    end
end
