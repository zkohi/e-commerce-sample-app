FactoryGirl.define do
  factory :coupon do
    title Faker::Book.unique.title
    code 3.times.map { ((0..9).to_a + ("a".."z").to_a + ("A".."Z").to_a).sample(4).join }.join("-")
    point Faker::Number.between(1, 999999)
  end
end
