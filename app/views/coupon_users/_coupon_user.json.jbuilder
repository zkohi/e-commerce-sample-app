json.extract! coupon_user, :id, :coupon_id, :user_id, :point, :created_at, :updated_at
json.url coupon_user_url(coupon_user, format: :json)
