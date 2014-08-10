class FacebookUser < ActiveRecord::Base
  has_many :photo_facebook_users, dependent: :destroy
  has_many :photos, through: :photo_facebook_users

  validates_uniqueness_of :identifier
end
