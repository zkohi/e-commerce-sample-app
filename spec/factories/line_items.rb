FactoryGirl.define do
  factory :line_item do
    order
    product
    quantity Faker::Number.between(1, 99)
    trait :with_price do
      price Faker::Number.between(1, 999999)
    end
    factory :line_item_with_product_stocks do
      transient do
        product_stocks_count 2
        product_stocks_stock 99
      end
      after(:build) do |line_item, evaluator|
        create_list :product_stock, evaluator.product_stocks_count, company: line_item.order.company, product: line_item.product, stock: evaluator.product_stocks_stock
      end
    end
  end
end
