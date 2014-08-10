class CreateFacebookUsers < ActiveRecord::Migration
  def change
    create_table :facebook_users do |t|
      t.string :identifier
      t.string :name

      t.timestamps
    end
  end
end
