FactoryGirl.define do
  factory :order do
    user_id 1
    state 1
    shipment_state 1
    payment_state 1
    item_count 1
    item_total 1
    shipment_total 1
    payment_total 1
    tax_total 1
    total 1
  end
end
