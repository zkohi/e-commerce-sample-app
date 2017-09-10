class Backoffice::OrdersController < Backoffice::ApplicationController
  def index
    @orders = Order.all.page(params[:page])
  end

  def show
    @order = Order.find(params[:id])
  end
end
