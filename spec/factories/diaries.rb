FactoryGirl.define do
  factory :diary do
    user
    content Faker::Book.unique.title
    trait :with_img_filename do
      img_filename { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures/', 'files', 'test.jpg'), 'image/jpg') }
    end
    trait :with_invalid_img_filename_extension do
      img_filename { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures/', 'files', 'test.txt')) }
    end
  end
end
