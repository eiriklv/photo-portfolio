json.array!(@photos) do |photo|
  json.extract! photo, :id, :name, :description, :position, :views, :album_id, :cam_id, :lens_id, :iso, :aperture, :exposure, :focal_distance, :thumb_url, :thumb_x2_url, :normal, :large, :xlarge, :likes, :comments
end
