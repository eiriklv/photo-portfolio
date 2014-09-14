class AddPhotosightUrlToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :photosight_url, :string
  end
end
