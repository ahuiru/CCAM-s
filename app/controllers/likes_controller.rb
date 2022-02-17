class LikesController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  def index
    @photos = Photo.joins(:likes).where(likes: {user_id: params[:user_id]})
  end

  def create
    @photo = Photo.find(params[:photo_id])
    current_user.likes.create(photo_id: params[:photo_id])
  end

  def destroy
    @photo = Photo.find(params[:photo_id])
    current_user.likes.find_by(photo_id: params[:photo_id]).destroy
  end
end
