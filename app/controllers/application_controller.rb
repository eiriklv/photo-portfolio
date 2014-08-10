class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!, except: [:frontend, :cams, :photos, :lenses, :albums]
  
  layout 'admin', except: [:frontend, :cams, :photos, :lenses, :albums]
  
  def frontend
    if request.env["HTTP_USER_AGENT"] =~ /MSIE 8.0/
      render layout: 'not_supported_browser'
    else
      @album = Album.find params[:album_id] if params.has_key? :album_id and params[:album_id] != 'all'
      @photo = Photo.find params[:photo_id] if params.has_key? :photo_id
      render layout: 'frontend'
    end
  end
end
