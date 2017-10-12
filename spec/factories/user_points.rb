FactoryGirl.define do
  factory :user_point do
    user
    user_coupon
    status "now"
    point Faker::Number.between(1, 999999)
  end
end
