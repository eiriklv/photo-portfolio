class AddFacebookIdToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :facebook_id, :string
  end
end
