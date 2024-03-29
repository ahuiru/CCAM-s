class LikesController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  def index
    likes = Like.where(user_id: current_user.id).order("created_at desc").pluck(:photo_id)
    @photos = Photo.find(likes)
  end

  def show
    @photo = Photo.find(params[:photo_id])
    @likes = Like.where(photo_id: @photo.id)
    # @user = User.find(id: @likes.user_id)
  end

  def create
    @photo = Photo.find(params[:photo_id])
    current_user.likes.create(photo_id: params[:photo_id])
    @photo.create_notification_like!(current_user)
  end

  def destroy
    @photo = Photo.find(params[:photo_id])
    current_user.likes.find_by(photo_id: params[:photo_id]).destroy
  end

end
