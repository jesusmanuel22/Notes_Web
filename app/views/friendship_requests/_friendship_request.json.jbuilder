json.extract! friendship_request, :id, :sender, :receiver, :text, :expiration_date, :created_at, :updated_at
json.url friendship_request_url(friendship_request, format: :json)
