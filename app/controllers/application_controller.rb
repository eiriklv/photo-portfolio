class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!, except: [:frontend, :cams, :photos, :lenses, :albums]
  
  layout 'admin', except: [:frontend, :cams, :photos, :lenses, :albums]
  
  def frontend
    @album = Album.find params[:album_id] if params.has_key? :album_id
    @photo = Photo.find params[:photo_id] if params.has_key? :photo_id
    render layout: 'frontend'
  end
end
