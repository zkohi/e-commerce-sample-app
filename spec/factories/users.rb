FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "#{n}" << Faker::Internet.unique.email }
    password "userpassword"
    password_confirmation "userpassword"
    trait :with_profile do
      name Faker::Name.unique.name
      zipcode Faker::Number.number(7)
      address [Faker::Address.state, Faker::Address.unique.city, Faker::Address.unique.street_name, Faker::Address.unique.street_address].join(" ")
      nickname Faker::Name.unique.name
    end
    trait :with_img_filename do
      img_filename { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures/', 'files', 'test.jpg'), 'image/jpg') }
    end
    trait :with_invalid_img_filename_extension do
      img_filename { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures/', 'files', 'test.txt')) }
    end
  end
end
