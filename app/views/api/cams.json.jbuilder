json.array!(@cams) do |cam|
  json.extract! cam, :id, :name
end
