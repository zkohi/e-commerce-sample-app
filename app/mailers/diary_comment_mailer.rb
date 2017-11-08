class DiaryCommentMailer < ApplicationMailer
  def post_comment_email(diary_comment)
    @diary_comment = diary_comment
    to = @diary_comment.diary.user.email
    subject = '新しいコメントが登録されました。'
    mail(to: to, subject: subject)
  end
end
