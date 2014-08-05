class Photo < ActiveRecord::Base
  belongs_to :cam
  belongs_to :lens
end
