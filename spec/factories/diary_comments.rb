FactoryGirl.define do
  factory :diary_comment do
    user nil
    diary nil
    content "MyText"
  end
end
