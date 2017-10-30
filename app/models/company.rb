class Company < ApplicationRecord
  has_many :product_stocks, dependent: :destroy, inverse_of: :company
  has_many :orders, dependent: :nullify, inverse_of: :company

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, length: { maximum: 50 }
end
