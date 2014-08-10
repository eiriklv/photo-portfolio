class CreateFacebookComments < ActiveRecord::Migration
  def change
    create_table :facebook_comments do |t|
      t.string :identifier
      t.references :photo, index: true
      t.references :facebook_user, index: true
      t.time :time
      t.text :message

      t.timestamps
    end
  end
end
