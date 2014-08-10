class CreatePhotoFacebookUsers < ActiveRecord::Migration
  def change
    create_table :photo_facebook_users do |t|
      t.references :photo, index: true
      t.references :facebook_user, index: true

      t.timestamps
    end
  end
end
