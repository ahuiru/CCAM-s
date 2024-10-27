# == Schema Information
#
# Table name: relationships
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  follow_id  :integer
#  user_id    :integer
#
# Indexes
#
#  index_relationships_on_follow_id              (follow_id)
#  index_relationships_on_user_id                (user_id)
#  index_relationships_on_user_id_and_follow_id  (user_id,follow_id) UNIQUE
#
# Foreign Keys
#
#  follow_id  (follow_id => users.id)
#  user_id    (user_id => users.id)
#
class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User'

  validates :user_id, presence: true
  validates :follow_id, presence: true, uniqueness: {scope: :user_id}

  def following?(other_user)
    self.followings.include?(other_user)
  end
end
