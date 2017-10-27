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
    factory :product_with_product_stocks do
      transient do
        product_stocks_count 2
        product_stocks_stock 99
      end
      after(:build) do |product, evaluator|
        create_list :product_stock, evaluator.product_stocks_count, company: create(:company), product: product, stock: evaluator.product_stocks_stock
      end
    end
  end
end
