class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  scope :accepted_friendships, -> { where(accepted: true) }
  scope :pending_friendships, -> { where(accepted: false) }
end
