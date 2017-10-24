class LineItem < ApplicationRecord
  belongs_to :order, inverse_of: :line_items
  validates_presence_of :order

  belongs_to :product

  default_scope -> { includes(:product) }

  validates :product_id, presence: true, numericality: { only_integer: true }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 99 }
  validates :price, allow_blank: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 999999 }, unless: :ordered?
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 999999 }, if: :ordered?
  validate :valid_quantity?, on: :create, if: Proc.new { |line_item| line_item.order.company_id.present? }

  after_create :sub_product_stock
  before_destroy :add_product_stock

  def product_stock
    @product_stock ||= self.product.product_stocks.find_by(company_id: self.order.company_id)
  end

  private

    def ordered?
      self.order.ordered?
    end

    def valid_quantity?
      if self.quantity > self.product_stock.stock
        errors.add(:quantity, "は#{stock}以下の値にしてください")
      end
    end

    def sub_product_stock
      self.product_stock.stock = self.product_stock.stock - self.quantity
      self.product_stock.save!
    end

    def add_product_stock
      self.product_stock.stock = self.product_stock.stock + self.quantity
      self.product_stock.save!
    end
end
