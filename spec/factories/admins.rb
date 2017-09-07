FactoryGirl.define do
  factory :admin do
    sequence(:email) { |n| "#{n}" << Faker::Internet.unique.email }
    password "userpassword"
    password_confirmation "userpassword"
  end
end
