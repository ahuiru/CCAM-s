class PhotosController < ApplicationController
    before_action :authenticate_user!, only: %i[new create destroy edit]

    def show
        @photo = Photo.find(params[:id])
        @comment = Comment.new
    end

    def new
        @photo = current_user.photos.new
    end

    def create
        @photo = current_user.photos.new(photo_params)

        if @photo.save
            redirect_to root_url, notice: '投稿しました'
        else
            flash.now[:alert] = '投稿に失敗しました'
            render action: "new"
        end
    end

    def destroy
        if current_user.photos.find(params[:id]).destroy
            flash.now[:success] = '投稿を削除しました'
            redirect_to [current_user]
        else
            flash.now[:alert] = '投稿の削除に失敗しました'
        end
    end

    def edit
        @photo = Photo.find(params[:id])
    end

    def update
        @photo = Photo.find(params[:id])
        if @photo.update(photo_params)
            redirect_to @photo
        else
            render :new
        end
    end



    private

     def photo_params
         params.require(:photo).permit(:image, :caption, :comic)
     end
end
