class DiaryEvaluation < ApplicationRecord
  belongs_to :user, inverse_of: :diary_evaluations
  belongs_to :diary, inverse_of: :diary_evaluations
end
