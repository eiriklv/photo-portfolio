class FacebookComment < ActiveRecord::Base
  belongs_to :photo
  belongs_to :facebook_user

  validates_uniqueness_of :identifier
end
