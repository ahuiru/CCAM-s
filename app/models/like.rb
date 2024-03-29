class Like < ApplicationRecord
  belongs_to :user
  belongs_to :photo

  validates :photo_id, presence: true, uniqueness: {scope: :user_id}
end
