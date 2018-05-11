json.extract! note, :id, :title, :text, :image, :created_at, :updated_at
json.url note_url(note, format: :json)
