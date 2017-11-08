require 'carrierwave/orm/activerecord'

class Diary < ApplicationRecord
  belongs_to :user, inverse_of: :diaries
  has_many :diary_comments, dependent: :destroy, inverse_of: :diary
  has_many :diary_evaluations, dependent: :destroy, inverse_of: :diary

  mount_uploader :img_filename, DiaryUploader

  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 500 }
end
