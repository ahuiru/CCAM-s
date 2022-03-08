class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    following = current_user.follow(@user)
    if following.save
      redirect_to @user, notice: 'ユーザーをフォローしました'
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      redirect_to @user
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      redirect_to @user, notice: 'ユーザーのフォローを解除しました'
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_to @user
    end
  end

  private

  def set_user
    @user = User.find(params[:follow_id])
  end
end
