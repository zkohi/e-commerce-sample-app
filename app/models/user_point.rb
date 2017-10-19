class UserPoint < ApplicationRecord
  belongs_to :user
  belongs_to :coupon, optional: true
  belongs_to :order, optional: true

  default_scope { order(created_at: :desc) }

  enum status: {
    now: 0,
    used: 1,
    coupon: 2,
    admin: 3
  }

  validates :status, inclusion: { in: ["now", "used", "coupon", "admin"] }
  validates :point, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: -999999, less_than_or_equal_to: 999999 }
end
