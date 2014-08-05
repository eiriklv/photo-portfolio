json.array!(@lens) do |len|
  json.extract! len, :id, :name
  json.url len_url(len, format: :json)
end
