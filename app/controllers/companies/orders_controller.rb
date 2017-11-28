class Companies::OrdersController < Companies::ApplicationController
  before_action :set_ordered_order, only: [:prosessing, :cancel]

  def index
    @orders = current_company.orders.where.not(state: :cart).includes(:user_point).order(created_at: :desc).page(params[:page])
  end

  def show
    @order = current_company.orders.where.not(state: :cart).includes(:user_point).find(params[:id])
  end

  def prosessing
    update_state(@order, "prosessing")
  end

  def shipped
    @order = current_company.orders.prosessing.find(params[:id])
    update_state(@order, "shipped")
  end

  def cancel
    update_state(@order, "canceled")
  end

  def reorder
    @order = current_company.orders.canceled.find(params[:id])
    update_state(@order, "reordered")
  end

  private
    def set_ordered_order
      @order = current_company.orders.where(state: [:ordered, :reordered]).find(params[:id])
    end

    def update_state(order, state)
      order.state = state
      if order.save
        redirect_to [:companies, @order], notice: "注文を#{order.state_i18n}にしました"
      else
        redirect_to [:companies, @order], notice: "注文を#{order.state_i18n}にできませんでした"
      end
    end
end
