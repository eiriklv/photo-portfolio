json.array!(@cams) do |cam|
  json.extract! cam, :id, :name
  json.url cam_url(cam, format: :json)
end
