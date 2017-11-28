FactoryGirl.define do
  factory :company do
    sequence(:email) { |n| "#{n}" << Faker::Internet.unique.email }
    password "userpassword"
    password_confirmation "userpassword"
    name Faker::Name.unique.name
    quantity_per_box Faker::Number.between(0, 999999)
  end
end
