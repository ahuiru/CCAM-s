class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :photos, dependent: :destroy

  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :rooms, through: :entries

  # mount_uploader :avatar, AvatarUploader
  has_one_attached :image

  validates :profile, length: { maximum: 200 }
  #userのshowページの編集の際、パスワードなしでも編集できるようにするために
  attr_accessor :current_password

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
      user.image.attach(io: File.open(Rails.root.join("app/assets/images/guest.png")), filename: "guest.png")
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
  end

  def guest?
    current_user == user.guest
    
  end

  def self.search_user(search)
    if search != ""
      User.where(['name LIKE(?) OR comic LIKE(?) OR email LIKE(?)', "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      User.includes(:user).order('created_at DESC')
    end
  end

end
