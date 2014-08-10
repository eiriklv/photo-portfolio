class Album < ActiveRecord::Base
  has_many :photos
  
  default_scope order 'position desc'
  
  def self.sort(ids)
    transaction do
      ids.each_with_index do |id, index|
        index = ids.count - index
        find(id).update_attribute(:position, index + 1)
      end
    end
  end

end
