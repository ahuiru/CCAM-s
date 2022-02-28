class RanksController < ApplicationController

  def index
    @photo = Photo.includes(:likes).sort {|a,b| b.likes.size <=> a.likes.size}
  end
end
