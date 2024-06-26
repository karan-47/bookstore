json.extract! cart, :id, :quanity, :created_at, :updated_at
json.url cart_url(cart, format: :json)
