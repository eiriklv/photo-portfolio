json.array!(@photos) do |photo|
  json.extract! photo, :id, :name, :description, :position, :views, :cam_id, :lens_id, :iso, :aperture, :exposure, :focal_distance
  json.url photo_url(photo, format: :json)
end
