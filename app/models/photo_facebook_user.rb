class PhotoFacebookUser < ActiveRecord::Base
  belongs_to :photo
  belongs_to :facebook_user

  validates_uniqueness_of :photo_id, scope: [ :facebook_user_id ]
end
