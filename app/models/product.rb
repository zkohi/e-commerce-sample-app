require 'carrierwave/orm/activerecord'

class Product < ApplicationRecord
  has_many :line_items
  has_many :orders, through: :line_items

  mount_uploader :img_filename, ProductUploader

  validates :name, presence: true, length: { maximum: 30 }
  validates :img_filename, allow_blank: true, length: { maximum: 30 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than: 1000000 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :flg_non_display, presence: true, inclusion: { in: [true, false] }
  validates :sort_order, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: 1000000 }
end
