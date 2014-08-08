class Photo < ActiveRecord::Base
  belongs_to :album
  belongs_to :cam
  belongs_to :lens

  has_attached_file :image, styles: {
    thumb: '320x320#',
    thumb_retina: '640x640#',
    normal: Proc.new { |instance| instance.resize_image('normal') }, # 1280x800
    large: Proc.new { |instance| instance.resize_image('large') }, # 2560x1600 or Retina 13"
    xlarge: Proc.new { |instance| instance.resize_image('xlarge') } # Retina 15"
  }, convert_options: {
    thumb: '-quality 80',
    thumb_retina: '-quality 80',
    normal: '-quality 80',
    large: '-quality 80',
    xlarge: '-quality 80'
  },default_url: '/images/:style/missing.png'
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  default_scope order 'position desc'
  
  paginates_per 10
  
  def thumb_url
    self.image.url :thumb
  end
  def thumb_x2_url
    self.image.url :thumb_retina
  end
  def normal
    self.image.url :normal
  end
  def large
    self.image.url :large
  end
  def xlarge
    self.image.url :xlarge
  end

  def resize_image(style)
    path = image.queued_for_write[:original].path
    geo = Paperclip::Geometry.from_file(path)

    case style
    when 'normal'
      if geo.horizontal?
        '1281x854#'
      else
        '854x1281#'
      end
    when 'large'
      if geo.horizontal?
        '2562x1708#'
      else
        '1708x2562#'
      end
    when 'xlarge'
      if geo.horizontal?
        '2880x1920#'
      else
        '1920x2880#'
      end
    end
  end

end
