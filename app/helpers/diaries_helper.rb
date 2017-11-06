module DiariesHelper
  def diary_created_at_ago(diary)
    sec = Time.now.to_i - diary.created_at.to_i
    sec < 60 ? "#{sec}秒前" : "#{time_ago_in_words(diary.created_at)}前"
  end
end
