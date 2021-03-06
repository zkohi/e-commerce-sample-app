class Order < ApplicationRecord
  attr_accessor :shipping_time_range
  attr_accessor :point_total
  attr_accessor :payjp_token

  belongs_to :user
  belongs_to :company
  has_one :user_point
  has_one :credit_charge

  has_many :line_items, dependent: :destroy, inverse_of: :order
  validates_associated :line_items
  accepts_nested_attributes_for :line_items

  validates :user_id, presence: true
  validates :company_id, presence: true
  validates :item_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :item_total, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :shipment_total, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :payment_total, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :adjustment_total, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :tax_total, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :total, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :point_total, allow_blank: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 999999 }

  with_options if: :ordered? do
    validates_date :shipping_date, presence: true
    validate :valid_point_total?
    validate :valid_shipping_date?
    validates :shipping_time_range_string, presence: true, inclusion: { in: ['8時〜12時', '12時〜14時', '14時〜16時', '16時〜18時', '18時〜20時', '20時〜21時'] }
    validates :user_name, presence: true, length: { maximum: 30 }
    validates :user_zipcode, presence: true, numericality: { only_integer: true }, length: { is: 7 }
    validates :user_address, presence: true, length: { maximum: 100 }
    validates :payment_type, presence: true, inclusion: { in: ['cash_on_delivery', 'credit'] }
  end

  after_find :set_item_count, :set_item_total, :set_shipment_total, :set_adjustment_total, :set_payment_total, :set_tax_total, :set_total, if: :cart?

  before_validation :set_shipping_time_range_string, if: ->(order) { order.shipping_time_range.present? }

  before_validation :set_payment_type_to_credit, if: ->(order) { order.payjp_token.present? && order.ordered? }

  with_options if: ->(order) { order.point_total.present? && order.ordered? } do
    before_validation :set_point_total, :set_adjustment_total, :set_payment_total, :set_tax_total, :set_total
    after_update :save_user_point!
  end

  before_update :set_payment_state_to_payed, if: ->(order) { order.credit? && order.ordered? }

  after_update :charge_payjp!, if: ->(order) { order.payjp_token.present? && order.ordered? }
  before_update :capture_payjp!, if: ->(order) { order.credit? && order.prosessing? }
  # 現仕様としては、注文キャンセル時に与信を解放し、業者管理画面からの再注文不可とする
  # 注文キャンセル時に与信を解放しなければ、業者の管理画面から再注文可能
  before_update :refund_payjp!, if: ->(order) { order.credit? && order.canceled? }

  after_update :add_product_stock!, if: :canceled?
  after_update :cancel_user_point!, if: ->(order) { order.user_point.present? && order.canceled? }

  after_update :sub_product_stock!, if: :reordered?
  after_update :reorder_user_point!, if: ->(order) { order.user_point.present? && order.reordered? }

  enum state: {
    cart: 0,
    ordered: 1,
    prosessing: 2,
    shipped: 3,
    canceled: 4,
    reordered: 5,
  }

  enum payment_state: {
    unpayed: 0,
    payed: 1,
    refunded: 2
  }

  enum shipping_time_range: {
    eight_to_twelve: 0,
    twelve_to_fourteen: 1,
    fourteen_to_sixteen: 2,
    sixteen_to_eighteen: 3,
    eighteen_to_twenty: 4,
    twenty_to_twenty_one: 5
  }

  enum payment_type: {
    cash_on_delivery: 0,
    credit: 1
  }

  def available_shipping_date_range
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

  private

    def set_payment_type_to_credit
      self.payment_type = 'credit'
      self.payment_total = 0
      self.tax_total = (self.adjustment_total * 0.08).floor
      self.total = self.adjustment_total + self.tax_total
    end

    def set_point_total
      self.point_total = self.point_total.to_i
    end

    def set_item_count
      self.item_count = self.line_items.inject(0) { |sum, i| sum + i.quantity }
    end

    def set_item_total
      self.item_total = self.line_items.inject(0) { |sum, i| sum + (i.product.price * i.quantity) }
    end

    def set_shipment_total
      self.shipment_total = (self.item_count / self.company.quantity_per_box.to_f).ceil * 600
    end

    def set_payment_total
      if self.cash_on_delivery?
        self.payment_total =
          case self.adjustment_total
          when 0
            0
          when 1 ... 10000
            300
          when 10000 ... 30000
            400
          when 30000 ... 100000
            600
          else
            1000
          end
      else
        self.payment_total = 0
      end
    end

    def set_adjustment_total
      self.adjustment_total = self.shipment_total + self.item_total
      if self.point_total.present?
        self.adjustment_total = self.adjustment_total - self.point_total
      end
    end

    def set_tax_total
      self.tax_total = ((self.adjustment_total + self.payment_total) * 0.08).floor
    end

    def set_total
      self.total = self.adjustment_total + self.payment_total + self.tax_total
    end

    def set_payment_state_to_payed
      self.payment_state = 'payed'
    end

    def valid_shipping_date?
      date_range = available_shipping_date_range
      today = Date.today
      if shipping_date.present? &&
        (shipping_date < (today + date_range[:minDate].days) || shipping_date > (today + date_range[:maxDate].days) ||
        (shipping_date.saturday? || shipping_date.sunday?))
        errors.add(:shipping_date, "は3営業日（営業日: 月-金）から14営業日までを指定してください")
      end
    end

    def valid_point_total?
      if self.point_total.present?
        use_point_max = self.shipment_total + self.item_total
        if self.point_total > use_point_max
          errors.add(:point_total, "は1以上#{use_point_max}以下の値にしてください")
        end

        user_point_total = user.user_points.total.first
        if user_point_total.blank?
          errors.add(:point_total, "がありません")
        elsif self.point_total > user_point_total.point
          errors.add(:point_total, "は#{user_point_total.point}以下の値にしてください")
        end
      end
    end

    def set_shipping_time_range_string
      self.shipping_time_range_string = Order.shipping_time_ranges_i18n[self.shipping_time_range]
    end

    def save_user_point!
      UserPoint.new(user_id: self.user_id, order_id: self.id, point: -self.point_total.to_i, status: 'used').save!
    end

    def cancel_user_point!
      self.user_point.status = 'canceled'
      self.user_point.save!
    end

    def reorder_user_point!
      self.user_point.status = 'used'
      self.user_point.save!
    end

    def sub_product_stock!
      self.line_items.each { |line_item| line_item.sub_product_stock! }
    end

    def add_product_stock!
      self.line_items.each { |line_item| line_item.add_product_stock! }
    end

    def charge_payjp!
      credit_charge = CreditCharge.new(order_id: self.id)
      credit_charge.charge!(self.payjp_token, self.total)
      credit_charge.save!
    end

    def capture_payjp!
      self.credit_charge.capture!
      self.payment_state = 'payed'
    end

    def refund_payjp!
      self.credit_charge.refund!
      self.payment_state = 'refunded'
    end
end
