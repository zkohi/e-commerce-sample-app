class User < ApplicationRecord
  has_many :orders

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, allow_blank: true, length: { maximum: 30 }
  validates :zipcode, allow_blank: true, numericality: { only_integer: true}, length: { is: 7 }
  validates :address, allow_blank: true, length: { maximum: 100 }
end
