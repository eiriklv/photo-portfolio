class AddCommentsToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :comments, :integer
  end
end
