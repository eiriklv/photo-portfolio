class CreateLens < ActiveRecord::Migration
  def change
    create_table :lens do |t|
      t.string :name

      t.timestamps
    end
  end
end
