class UserPoint < ApplicationRecord
  belongs_to :user, inverse_of: :user_points
  belongs_to :coupon, optional: true, inverse_of: :user_points
  belongs_to :order, optional: true

  default_scope { order(created_at: :desc) }

  enum status: {
    total: 0,
    used: 1,
    coupon: 2,
    admin: 3,
    canceled: 4
  }

  validates :status, inclusion: { in: ["total", "used", "coupon", "admin", "canceled"] }
  validates :point, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: -999999, less_than_or_equal_to: 999999 }, unless: :total?
  validates :point, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 999999 }, if: :total?

  after_create :update_total, unless: :total?
  after_update :update_total, if: :used?
  after_update :cancel_point, if: :canceled?

  private

    def update_total
      total = UserPoint.find_or_initialize_by(user_id: self.user_id, status: :total)
      total.status = "total"
      total.point = total.point.to_i + self.point
      total.save!
    end

    def cancel_point
      total = self.user.user_points.total.first
      total.point = total.point.to_i - self.point
      total.save!
    end
end
