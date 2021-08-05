json.extract! user, :id, :email, :salted_password_hash, :salt, :created_at, :updated_at
json.url user_url(user, format: :json)
