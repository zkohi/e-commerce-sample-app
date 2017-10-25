module DiariesHelper
  def diary_created_at_ago(diary)
    min = ((Time.now - diary.created_at).ceil / 60).ceil
    return "#{min}分前" if min < 60

    hour = (min / 60).ceil
    hour < 24 ? "#{hour}時間前" : "#{(hour / 24).ceil}日前"
  end
end
