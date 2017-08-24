require 'carrierwave/orm/activerecord'

class Product < ApplicationRecord
  has_many :line_items
  has_many :orders, through: :line_items

  mount_uploader :img_filename, ProductUploader
end
