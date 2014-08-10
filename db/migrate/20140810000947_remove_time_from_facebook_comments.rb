class RemoveTimeFromFacebookComments < ActiveRecord::Migration
  def change
    remove_column :facebook_comments, :time
  end
end
