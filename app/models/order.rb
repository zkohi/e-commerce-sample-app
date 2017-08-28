class Order < ApplicationRecord
  attr_accessor :shipping_time_range

  has_many :line_items, dependent: :destroy
  belongs_to :user

  accepts_nested_attributes_for :line_items

  enum state: {
    cart: 0,
    ordered: 1
  }

  enum shipment_state: {
    unshipped: 0,
    shipped: 1
  }

  enum payment_state: {
    unpayed: 0,
    payed: 1
  }

  enum shipping_time_range: {
    eight_to_twelve: 0,
    twelve_to_fourteen: 1,
    fourteen_to_sixteen: 2,
    sixteen_to_eighteen: 3,
    eighteen_to_twenty: 4,
    twenty_to_twenty_one: 5
  }

  def execute(params)
    self.state = "ordered"
    self.shipping_time_range_string = Order.shipping_time_ranges_i18n[params["shipping_time_range"]]
    self.update(params)
  end

  def available_shipping_date
    # 3営業日（営業日: 月-金）から14営業日まで
    # [当日含む]でよいかは要確認
    today = Date.today
    if today.sunday?
      {
        minDate: 3,
        maxDate: 18
      }
    elsif today.thursday? || today.friday? || today.saturday?
      {
        minDate: 4,
        maxDate: 19
      }
    elsif today.wednesday?
      {
        minDate: 2,
        maxDate: 19
      }
    else
      {
        minDate: 2,
        maxDate: 17
      }
    end
  end

  def save_for_add_line_item!(params)
    line_items_attributes = params["line_items_attributes"]["0"]
    set_item_count(line_items_attributes)
    set_item_total(line_items_attributes)
    set_shipment_total
    set_payment_total
    set_adjustment_total
    set_tax_total
    self.total = self.adjustment_total + self.tax_total
    save!(params)
  end

  def update_for_delete_line_item!
    sum_item_count
    sum_item_total
    set_shipment_total
    set_payment_total
    set_adjustment_total
    set_tax_total
    self.total = self.adjustment_total + self.tax_total
    update!({})
  end

  private

  def set_item_count(line_items_attributes)
    self.item_count += line_items_attributes["quantity"].to_i
  end

  def sum_item_count
    self.item_count = self.line_items.sum(:quantity)
  end

  def set_item_total(line_items_attributes)
    self.item_total += Product.find(line_items_attributes["product_id"]).price * line_items_attributes["quantity"].to_i
  end

  def sum_item_total
    self.item_total = self.line_items.includes(:product).sum('products.price * quantity')
  end

  def set_shipment_total
    self.shipment_total = (self.item_count / 5.0).ceil * 600
  end

  def set_payment_total
    self.payment_total = case self.item_total
                         when 0 ... 10000
                           300
                         when 10000 ... 30000
                           400
                         when 30000 ... 100000
                           600
                         else
                           1000
                         end
  end

  def set_adjustment_total
    self.adjustment_total = self.shipment_total + self.item_total + self.payment_total
  end

  def set_tax_total
    self.tax_total = (self.adjustment_total * 0.08).floor
  end

end
