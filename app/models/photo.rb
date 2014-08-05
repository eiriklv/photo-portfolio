class Photo < ActiveRecord::Base
  belongs_to :album
  belongs_to :cam
  belongs_to :lens

  has_attached_file :image, styles: { medium: '300x300>', thumb: '100x100#' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  default_scope order 'position desc'
  
  paginates_per 10

end
