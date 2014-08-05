class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :name
      t.text :description
      t.integer :position
      t.integer :views
      t.references :cam, index: true
      t.references :lens, index: true
      t.integer :iso
      t.float :aperture
      t.string :exposure
      t.integer :focal_distance

      t.timestamps
    end
  end
end
