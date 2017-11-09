class Companies::OrdersController < Companies::ApplicationController

  def index
    @orders = current_company.orders.where.not(state: :cart).includes(:user_point).order(created_at: :desc).page(params[:page])
  end

  def show
    @order = current_company.orders.where.not(state: :cart).includes(:user_point).find(params[:id])
  end

  def prosessing
    @order = current_company.orders.ordered.find(params[:id])
    update_state(@order, "prosessing")
  end

  def shipped
    @order = current_company.orders.prosessing.find(params[:id])
    update_state(@order, "shipped")
  end

  def cancel
    @order = current_company.orders.ordered.find(params[:id])
    update_state(@order, "canceled")
  end

  def revert
    @order = current_company.orders.where(state: [:prosessing, :shipped, :canceled]).find(params[:id])
    update_state(@order, "ordered")
  end

  private

    def update_state(order, state)
      order.state = state
      if order.save
        redirect_to [:companies, @order], notice: "注文を#{order.state_i18n}にしました"
      else
        redirect_to [:companies, @order], notice: "注文を#{order.state_i18n}にできませんでした"
      end
    end
end
