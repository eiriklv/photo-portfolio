class CreateCams < ActiveRecord::Migration
  def change
    create_table :cams do |t|
      t.string :name

      t.timestamps
    end
  end
end
