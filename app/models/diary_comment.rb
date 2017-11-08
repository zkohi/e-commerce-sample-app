class DiaryComment < ApplicationRecord
  belongs_to :user, inverse_of: :diary_comments
  belongs_to :diary, inverse_of: :diary_comments

  validates :content, presence: true, length: { maximum: 500 }
end
