class RanksController < ApplicationController

  def index
    @photo = Photo.find(Like.group(:photo_id).order('count(photo_id) desc').limit(10).pluck(:photo_id))
  end
end
