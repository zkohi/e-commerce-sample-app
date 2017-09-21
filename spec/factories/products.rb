FactoryGirl.define do
  factory :product do
    name Faker::Name.unique.name
    img_filename nil
    price Faker::Number.between(1, 999999)
    trait :with_price_1000 do
      price 1000
    end
    description Faker::Book.unique.title
    flg_non_display "display"
    sort_order Faker::Number.between(1, 999)
    trait :with_img_filename do
      img_filename { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures/', 'files', 'test.jpg'), 'image/jpg') }
    end
    trait :with_invalid_img_filename_extension do
      img_filename { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures/', 'files', 'test.txt')) }
    end
  end
end
