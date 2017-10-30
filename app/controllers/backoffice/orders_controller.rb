class Backoffice::OrdersController < Backoffice::ApplicationController
  def index
    @orders = Order.includes(:company).includes(:user_point).order(created_at: :desc).page(params[:page])
  end

  def show
    @order = Order.includes(:company).includes(:user_point).find(params[:id])
  end
end
