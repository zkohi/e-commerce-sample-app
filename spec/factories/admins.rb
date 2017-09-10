FactoryGirl.define do
  factory :admin do
    sequence(:email) { |n| "#{n}" << Faker::Internet.unique.email }
    password "adminpassword"
    password_confirmation "adminpassword"
  end
end
