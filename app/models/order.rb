class Order < ApplicationRecord
  has_many :line_items
  belongs_to :user

  accepts_nested_attributes_for :line_items
end
