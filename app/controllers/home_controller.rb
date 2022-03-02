class HomeController < ApplicationController
  before_action :authenticate_user!

 def index
  @feeds = Photo.all.order(created_at: :desc)
 end
end
