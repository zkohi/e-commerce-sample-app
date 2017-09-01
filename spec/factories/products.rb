FactoryGirl.define do
  factory :product do
    name Faker::Name.unique.name
    img_filename Faker::File.unique.file_name
    price Faker::Number.between(1, 999999)
    description Faker::Book.unique.title
    flg_non_display false
    sort_order Faker::Number.between(1, 999)
  end
end
