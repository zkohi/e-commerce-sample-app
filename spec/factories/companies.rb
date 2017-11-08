FactoryGirl.define do
  factory :company do
    sequence(:email) { |n| "#{n}" << Faker::Internet.unique.email }
    password "userpassword"
    password_confirmation "userpassword"
    name Faker::Name.unique.name
  end
end
