class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User'

  validates :user_id, presence: true
  validates :follow_id, presence: true, uniqueness: {scope: :user_id}

  def following?(other_user)
    self.followings.include?(other_user)
  end
end
