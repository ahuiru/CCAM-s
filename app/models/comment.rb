# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  photo_id   :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_comments_on_photo_id  (photo_id)
#  index_comments_on_user_id   (user_id)
#
# Foreign Keys
#
#  photo_id  (photo_id => photos.id)
#  user_id   (user_id => users.id)
#
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :photo
  has_many :notifications, dependent: :destroy

  validates :body, presence: true
end
