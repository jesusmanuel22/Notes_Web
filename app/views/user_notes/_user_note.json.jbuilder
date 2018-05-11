json.extract! user_note, :id, :id_user, :id_note, :created_at, :updated_at
json.url user_note_url(user_note, format: :json)
