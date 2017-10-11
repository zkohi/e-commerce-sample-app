FactoryGirl.define do
  factory :user_coupon do
    user
    coupon
    point Faker::Number.between(1, 999999)
  end
end
