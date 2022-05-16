class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @photo = Photo.find(params[:photo_id])
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      @photo.create_notification_comment!(current_user, @comment.id)
      redirect_to [@photo]
    else
      flash.now[:alert] = '送信に失敗しました'
      render 'photos/show'
    end
  end

  def destroy
    puts "detroy"
    comment = current_user.comments.find(params[:id])
    comment.destroy

    redirect_to [:photo, { id: params[:photo_id] }]
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(photo_id: params[:photo_id])
  end
end
