FactoryGirl.define do
  factory :diary_comment do
    user
    diary
    content Faker::Book.unique.title
  end
end
