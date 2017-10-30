class User < ApplicationRecord
  has_many :orders
  has_many :diaries, dependent: :destroy, inverse_of: :user
  has_many :diary_comments, dependent: :destroy, inverse_of: :user
  has_many :diary_evaluations, dependent: :destroy, inverse_of: :user
  has_many :user_points, dependent: :destroy, inverse_of: :user

  mount_uploader :img_filename, UserUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, allow_blank: true, length: { maximum: 30 }
  validates :zipcode, allow_blank: true, numericality: { only_integer: true }, length: { is: 7 }
  validates :address, allow_blank: true, length: { maximum: 100 }
  validates :nickname, allow_blank: true, length: { maximum: 30 }
end
