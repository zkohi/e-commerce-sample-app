class LineItem < ApplicationRecord
  belongs_to :order, inverse_of: :line_items
  validates_presence_of :order

  belongs_to :product

  default_scope -> { includes(:product) }

  validates :product_id, presence: true, numericality: { only_integer: true }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 99 }
  validates :price, allow_blank: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 999999 }, unless: :ordered?
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 999999 }, if: :ordered?
  validate :valid_quantity?, on: :create, if: ->(line_item) { line_item.order.company_id.present? && line_item.product.present? && line_item.quantity.present? }

  after_create :sub_product_stock!
  before_destroy :add_product_stock!

  def product_stock
    @product_stock ||= self.product.product_stocks.find_by(company_id: self.order.company_id)
  end

  def sub_product_stock!
    self.product_stock.update_stock!(-self.quantity)
  end

  def add_product_stock!
    self.product_stock.update_stock!(self.quantity)
  end

  private

    def ordered?
      self.order.ordered?
    end

    def valid_quantity?
      if self.quantity > self.product_stock.stock
        errors.add(:quantity, "は#{self.product_stock.stock}以下の値にしてください")
      end
    end
end
