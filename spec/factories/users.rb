FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "#{n}" << Faker::Internet.unique.email }
    password "userpassword"
    password_confirmation "userpassword"
    trait :with_profile do
      name Faker::Name.unique.name
      zipcode Faker::Number.number(7)
      address [Faker::Address.state, Faker::Address.unique.city, Faker::Address.unique.street_name, Faker::Address.unique.street_address].join(" ")
    end

  end
end
