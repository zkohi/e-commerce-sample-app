class Coupon < ApplicationRecord
  has_many :user_points, dependent: :destroy, inverse_of: :coupon

  validates :title, presence: true, length: { maximum: 50 }
  validates :code, presence: true, uniqueness: true, format: { with: /\A([a-zA-Z0-9]){4}-([a-zA-Z0-9]){4}-([a-zA-Z0-9]){4}\z/ }
  validates :point, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 999999 }
end
