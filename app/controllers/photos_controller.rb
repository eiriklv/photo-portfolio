class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy, :publish_on_facebook, :refresh_from_facebook]

  layout 'admin'

  def publish_on_facebook
    me = FbGraph::User.me current_user.access_token
    album = FbGraph::Album.new @photo.album.facebook_id, access_token: current_user.access_token
    photo = album.photo!(
      access_token: current_user.access_token,
      source: File.new(@photo.image.path(:normal)),
      message: @photo.name
    )
    @photo.update facebook_id: photo.raw_attributes['id']
    redirect_to photos_url, notice: 'Photo was successfully published to Facebook.'
  end
  
  def refresh_from_facebook
    me = FbGraph::User.me current_user.access_token
    photo = FbGraph::Photo.new @photo.facebook_id, access_token: current_user.access_token

    @photo.facebook_users = []
    likes = photo.likes
    while likes.count > 0
      save_likes likes, @photo
      likes = likes.next
    end
    @photo.update likes: @photo.facebook_users.count

    @photo.facebook_comments.destroy_all
    comments = photo.comments
    while comments.count > 0
      save_comments comments, @photo
      comments = comments.next
    end
    @photo.update comments: @photo.facebook_comments.count

    redirect_to photos_url, notice: 'Photo data was successfully refreshed from Facebook.'
  end

  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all
    # @photos = @photos.where(album_id: params[:album_id]) if params.has_key? :album_id
    # @photos = @photos.page params[:page]
  end

  # GET /photos/1
  # GET /photos/1.json
  # def show
  # end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)

    respond_to do |format|
      if @photo.save
        maximumPosition = Photo.maximum('position')
        maximumPosition = 0 unless maximumPosition.present?
        @photo.update position: maximumPosition + 1
        format.html { redirect_to photos_url, notice: 'Photo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @photo }
      else
        format.html { render action: 'new' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to photos_url, notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json { head :no_content }
    end
  end

  def sort
    Photo.sort params[:ids].split(',')
    render text: 1
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:name, :description, :position, :views, :cam_id, :lens_id, :iso, :aperture, :exposure, :focal_distance, :image, :date, :album_id)
    end
    
    def save_likes (likes, _photo)
      likes.each do |user|
        facebookUser = FacebookUser.find_by_identifier user.identifier
        facebookUser = FacebookUser.create(identifier: user.identifier, name: user.name) unless facebookUser.present?
        begin
          _photo.facebook_users << facebookUser
        rescue
          true
        end
      end
    end
    
    def save_comments (comments, _photo)
      comments.each do |comment|
        facebookUser = FacebookUser.find_by_identifier comment.from.identifier
        facebookUser = FacebookUser.create(identifier: comment.from.identifier, name: comment.from.name) unless facebookUser.present?
        facebookComment = FacebookComment.find_by_identifier comment.identifier
        facebookComment = FacebookComment.create(identifier: comment.identifier, facebook_user_id: facebookUser.id, photo_id: _photo.id, created_at: comment.created_time, message: comment.message) unless facebookComment.present?
      end
    end
end
