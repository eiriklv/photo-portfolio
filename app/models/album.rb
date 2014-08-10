class Album < ActiveRecord::Base
  has_many :photos
  
  default_scope order 'position desc'
  
  after_create :createOnFacebook

  def self.sort(ids)
    transaction do
      ids.each_with_index do |id, index|
        index = ids.count - index
        find(id).update_attribute(:position, index + 1)
      end
    end
  end

  private

  def createOnFacebook
    me = FbGraph::User.me Rails.application.config.FB_ACCESS_TOKEN
    album = me.album! name: self.name
    self.update facebook_id: album.raw_attributes['id']
  end

end
