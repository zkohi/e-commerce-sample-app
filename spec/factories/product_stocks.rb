FactoryGirl.define do
  factory :product_stock do
    product
    company
    stock Faker::Number.between(1, 999999)
  end
end
