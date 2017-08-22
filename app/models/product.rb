require 'carrierwave/orm/activerecord'

class Product < ApplicationRecord
  mount_uploader :filename, ProductUploader
end
