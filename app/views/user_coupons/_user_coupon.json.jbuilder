json.extract! user_coupon, :id, :user_id, :coupon_id, :point, :created_at, :updated_at
json.url user_coupon_url(user_coupon, format: :json)
