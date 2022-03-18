class RanksController < ApplicationController

  def index
    @photo = Photo.find(Like.group(:photo_id).order('count(photo_id) desc').limit(5).pluck(:photo_id))
  end
end
