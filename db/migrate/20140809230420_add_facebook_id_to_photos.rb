class AddFacebookIdToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :facebook_id, :string
  end
end
