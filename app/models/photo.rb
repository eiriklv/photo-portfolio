class Photo < ActiveRecord::Base
  belongs_to :album
  belongs_to :cam
  belongs_to :lens

  has_attached_file :image, styles: {
    thumb: '320x320#',
    thumb_retina: '640x640#'
  }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  default_scope order 'position desc'
  
  paginates_per 10
  
  def thumb_url
    self.image.url :thumb
  end

  def thumb_x2_url
    self.image.url :thumb_retina
  end

end
