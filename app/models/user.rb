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

  def set_diary_evaluation_ids(diaries)
    @diary_evaluation_ids = self.diary_evaluations.where(diary_id: diaries.pluck(:id)).each_with_object({}) {|i, d| d[i.diary_id] = i.id}
  end

  def diary_evaluated?(diary)
    @diary_evaluation_ids.has_key?(diary.id) 
  end

  def diary_evaluation_id(diary)
    @diary_evaluation_ids[diary.id]
  end
end
