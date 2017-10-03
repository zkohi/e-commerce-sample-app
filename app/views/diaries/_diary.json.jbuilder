json.extract! diary, :id, :user_id, :content, :img_filename, :created_at, :updated_at
json.url diary_url(diary, format: :json)
