json.extract! diary_comment, :id, :user_id, :diary_id, :content, :created_at, :updated_at
json.url diary_comment_url(diary_comment, format: :json)
