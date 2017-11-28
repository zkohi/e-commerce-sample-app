class ProductStock < ApplicationRecord
  belongs_to :product, inverse_of: :product_stocks
  belongs_to :company, inverse_of: :product_stocks

  validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 999999 }

  def update_stock!(quantity)
    self.stock = self.stock + quantity
    self.save!
  end
end
