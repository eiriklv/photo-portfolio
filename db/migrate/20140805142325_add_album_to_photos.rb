class AddAlbumToPhotos < ActiveRecord::Migration
  def change
    add_reference :photos, :album, index: true
  end
end
