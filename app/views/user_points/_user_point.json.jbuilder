json.extract! user_point, :id, :user_id, :user_coupon_id, :status, :point, :created_at, :updated_at
json.url user_point_url(user_point, format: :json)
