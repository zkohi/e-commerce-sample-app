require 'carrierwave/orm/activerecord'

class Diary < ApplicationRecord
  belongs_to :user
  has_many :diary_comments
  has_many :diary_evaluations, through: :user

  mount_uploader :img_filename, DiaryUploader

  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 500 }
end
