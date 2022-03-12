class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_action :likes_show


  protect_from_forgery with: :exception

  add_flash_types :success, :info, :warning, :danger

  helper_method :current_user, :logged_in?, :log_in, :login_check
  # before_create :default_image

  # ログイン済ユーザーのみにアクセスを許可する
  before_action :authenticate_user!

  # deviseコントローラーにストロングパラメータを追加する
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    # サインアップ時にnameのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :image])
    # アカウント編集の時にnameとprofileのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile, :image, :comic])
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !current_user.nil?
  end

  def login_check
    if current_user.nil?
      redirect_to root_url, danger: "ログインしてください"
    end
  end
  

  # def default_image
  #   if !self.image.attached?
  #     self.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default.png')), filename: 'default.jpeg', content_type: 'image/jpeg')
  #   end
  # end

end
