class ApiController < ApplicationController

  def cams
    @cams = Cam.all
  end

  def lenses
    @lenses = Lens.all
  end

  def albums
    @albums = Album.all
  end

  def photos
    @photos = Photo.all
  end

end
