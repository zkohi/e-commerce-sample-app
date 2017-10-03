require 'carrierwave/orm/activerecord'

class Diary < ApplicationRecord
  belongs_to :user

  mount_uploader :img_filename, DiaryUploader

  validates :content, presence: true, length: { maximum: 500 }
end
