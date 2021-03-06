require 'carrierwave/orm/activerecord'

class Product < ApplicationRecord
  has_many :line_items
  has_many :orders, through: :line_items
  has_many :product_stocks, dependent: :destroy, inverse_of: :product

  mount_uploader :img_filename, ProductUploader

  enum flg_non_display: {
    display: false,
    non_display: true
  }

  validates :name, presence: true, length: { maximum: 30 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 999999 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :flg_non_display, inclusion: { in: ["display", "non_display"] }
  validates :sort_order, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 999999 }
end
