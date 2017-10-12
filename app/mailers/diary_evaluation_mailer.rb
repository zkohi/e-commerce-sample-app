class DiaryEvaluationMailer < ApplicationMailer
  def post_evaluation_email(diary_evaluation)
    @diary_evaluation = diary_evaluation
    to = @diary_evaluation.diary.user.email
    subject = '新しい評価が登録されました。'
    mail(to: to, subject: subject)
  end
end
