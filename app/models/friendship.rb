class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  scope :accepted_friendships, -> { where(accepted: true) }
  scope :pending_friendships, -> { where(accepted: false) }

  private

  def self.send_friend_request user_id, friend_id
    # User who requests friendship defaults to accepting the Friend Request
    Friendship.create user_id: user_id, friend_id: friend_id, accepted: true
    # Reciprocate request from other 'side' of friendship
    Friendship.create user_id: friend_id, friend_id: user_id
  end
end
