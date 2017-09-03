FactoryGirl.define do
  factory :line_item do
    order
    product
    quantity Faker::Number.between(1, 99)
    trait :with_price do
      price Faker::Number.between(1, 999999)
    end

  end
end
