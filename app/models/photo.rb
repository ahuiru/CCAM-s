class Photo < ApplicationRecord
  belongs_to :user


  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :image, presence: true

  def self.search_photo(search)
    if search != ""
      Photo.where(['caption LIKE(?) OR comic LIKE(?)', "%#{search}%", "%#{search}%"]).order(created_at: :desc)
    else
      Photo.includes(:user).order('created_at DESC')
    end
  end
end
