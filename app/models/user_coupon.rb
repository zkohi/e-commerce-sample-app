class UserCoupon < ApplicationRecord
  belongs_to :user
  belongs_to :coupon
  has_many :user_points

  validates :point, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 999999 }
end
