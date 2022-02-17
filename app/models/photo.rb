class Photo < ApplicationRecord
  belongs_to :user


  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :image, presence: true

  
end
