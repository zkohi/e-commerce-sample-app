FactoryGirl.define do
  factory :product do
    name "MyString"
    filename "MyString"
    price 1
    description "MyText"
    flg_non_display false
    sort_order 1
  end
end
