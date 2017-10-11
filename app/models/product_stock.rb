class ProductStock < ApplicationRecord
  belongs_to :product
  belongs_to :company

  validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 999999 }
end
