class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  default_scope -> { includes(:product) }

  validates :product_id, presence: true, numericality: { only_integer: true }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than: 100 }
  validates :price, allow_blank: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than: 1000000 }, unless: :ordered?
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than: 1000000 }, if: :ordered?

  def ordered?
    self.order.ordered?
  end
end
