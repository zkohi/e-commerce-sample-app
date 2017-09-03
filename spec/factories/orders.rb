FactoryGirl.define do
  factory :order do
    user
    state "cart"
    item_count 1
    item_total 1
    shipment_state 0
    payment_state 0
    shipment_total 1
    payment_total 1
    tax_total 1
    total 1
    trait :ordered do
      state "ordered"
      item_count 1
      item_total 1
      shipment_state 0
      payment_state 0
      shipment_total 1
      payment_total 1
      tax_total 1
      total 1
      shipping_date { Date.today + 2.days }
      shipping_time_range_string "8時〜12時"
      user_name Faker::Name.unique.name
      user_zipcode Faker::Number.number(7)
      user_address [Faker::Address.state, Faker::Address.unique.city, Faker::Address.unique.street_name, Faker::Address.unique.street_address].join(" ")
    end
  end
end
