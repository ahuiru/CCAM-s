class SearchesController < ApplicationController

  # def search
  #   if params[:name].present?
  #     @users = User.where('name LIKE ?', "%#{params[:name]}%")
  #     @photos = Photo.where('name LIKE ?', "%#{params[:name]}%")
  #   else
  #     @users = User.none
  #     @photos = Photo.none
  #   end
  # end

  def search
    if params[:keyword].present?
      @photos = Photo.search_photo(params[:keyword])
      # @users = User.search_user(params[:keyword])
    else
      # @users = User.none
      @photos = Photo.none
    end
  end

end
