class HomeController < ApplicationController
  before_action :authenticate_user!

 def index
  @feeds = Photo.all
 end
end
