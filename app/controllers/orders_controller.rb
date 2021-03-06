class OrdersController < Users::ApplicationController
  before_action :set_order, only: [:edit, :confirm, :update, :destroy_cart_line_item]
  before_action :set_order_state_to_ordered, only: [:confirm, :update]

  def index
    @orders = current_user.orders.where.not(state: :cart).includes(:company).includes(:user_point).order(created_at: :desc).page(params[:page])
  end

  def show
    @order = current_user.orders.where.not(state: :cart).includes(:company).includes(:user_point).find(params[:id])
  end

  def create
    @order = current_user.orders.find_or_initialize_by(state: :cart, company_id: order_line_item_params[:company_id])
    @order.attributes = order_line_item_params
    if @order.save
      redirect_to carts_path
    else
      redirect_to product_path(order_line_item_params[:line_items_attributes]["0"][:product_id]), notice: '業者を選択し、数量を入力してください'
    end
  end

  def cart
    @orders = current_user.orders.cart.includes(:company).includes(:line_items).where(state: :cart).order(created_at: :desc).all
  end

  def edit
  end

  def confirm
    @order.attributes = order_params.merge(payjp_token: params[:"payjp-token"])
    if @order.valid?
      render :confirm
    else
      render :edit
    end
  end

  def update
    if @order.update(order_params)
      redirect_to @order, notice: 'ご注文完了しました'
    else
      render :confirm
    end
  end

  def cancel
    @order = current_user.orders.where(state: [:ordered, :reordered]).find(params[:id])
    update_state(@order, "canceled")
  end

  def reorder
    @order = current_user.orders.canceled.find(params[:id])
    update_state(@order, "reordered")
  end

  def destroy_cart_line_item
    @order.line_items.find(params[:line_item_id]).destroy
    redirect_to carts_path, notice: '商品が削除されました'
  end

  private
    def set_order
      @order = current_user.orders.cart.find(params[:id])
    end

    def set_order_state_to_ordered
      @order.state = "ordered"
    end

    def order_line_item_params
      params.require(:order).permit(
        :company_id,
        line_items_attributes: [
          :product_id,
          :quantity,
        ]
      )
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
        :payment_type,
        :point_total,
        :payjp_token,
        line_items_attributes: [
          :id,
          :product_id,
          :quantity,
          :price
        ]
      )
    end

    def update_state(order, state)
      order.state = state
      if order.save
        redirect_to @order, notice: "ご注文を#{order.state_i18n}にしました"
      else
        redirect_to @order, notice: "ご注文を#{order.state_i18n}にできませんでした"
      end
    end
end
