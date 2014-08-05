class Album < ActiveRecord::Base
  has_many :photos
  
  default_scope order 'position desc'
end
