class Photo < ActiveRecord::Base
  belongs_to :album
  belongs_to :cam
  belongs_to :lens

  has_attached_file :image, styles: {
    preview: '70x70>',
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
  
  after_post_process :load_exif
  
  # paginates_per 10
  
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

  def self.sort(ids)
    transaction do
      ids.each_with_index do |id, index|
        index = ids.count - index
        find(id).update_attribute(:position, index + 1)
      end
    end
  end


  def load_exif
    exif = EXIFR::JPEG.new(image.queued_for_write[:original].path)
    return if exif.nil? or not exif.exif?
    begin
      p exif.model
      p exif
      self.exposure = exif.exposure_time.to_s.gsub /\/1$/, ''
      self.aperture = exif.f_number.to_f
      self.focal_distance = exif.focal_length.to_i
      self.iso = exif.iso_speed_ratings.to_i
      self.date = exif.date_time.to_date
    rescue
      false
    end
  end

end
