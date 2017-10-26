module DiariesHelper
  def diary_created_at_ago(diary)
    sec = Time.now.to_i - diary.created_at.to_i
    return "#{sec}秒前" if sec < 60

    min = (sec / 60).ceil
    return "#{min}分前" if min < 60

    hour = (min / 60).ceil
    hour < 24 ? "#{hour}時間前" : "#{(hour / 24).ceil}日前"
  end
end
