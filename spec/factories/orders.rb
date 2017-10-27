FactoryGirl.define do
  factory :order do
    user
    company
    state "cart"
    item_count 2
    item_total 2000
    shipment_state 0
    payment_state 0
    shipment_total 600
    adjustment_total 2600
    payment_total 300
    tax_total 232
    total 3132
    shipping_time_range "eight_to_twelve"
    transient do
      line_items_count 2
    end
    factory :order_with_line_items do
      after(:create) do |order, evaluator|
        create_list :line_item, evaluator.line_items_count, order: order, product: create(:product, :with_price_1000), quantity: 10
      end
    end
    trait :with_point_total do
      point_total "1000"
    end
    trait :ordered do
      state "ordered"
      item_count 2
      item_total 2000
      shipment_state 0
      payment_state 0
      shipment_total 600
      adjustment_total 2600
      payment_total 300
      tax_total 232
      total 3132
      shipping_date { Date.today + 2.days }
      shipping_time_range "eight_to_twelve"
      shipping_time_range_string "8時〜12時"
      user_name Faker::Name.unique.name
      user_zipcode Faker::Number.number(7)
      user_address [Faker::Address.state, Faker::Address.unique.city, Faker::Address.unique.street_name, Faker::Address.unique.street_address].join(" ")
    end
  end
end
