FactoryGirl.define do
  factory :user_point do
    user
    trait :user_point_total do
      coupon nil
      status "total"
      point Faker::Number.between(0, 999999)
      order nil
    end

    trait :user_point_coupon do
      coupon
      status "coupon"
      point Faker::Number.between(1, 999999)
      order nil
    end

    trait :user_point_used do
      coupon nil
      status "used"
      point -Faker::Number.between(1, 999999)
      order
    end

    trait :user_point_admin do
      coupon nil
      status "admin"
      point Faker::Number.between(1, 999999)
      order nil
    end
  end
end
