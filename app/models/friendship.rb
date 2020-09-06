class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  scope :accepted_friendships, -> { where(accepted: true) }
  scope :pending_friendships, -> { where(accepted: false) }

  private

  def self.send_friend_request user_id, friend_id
    # User who requests friendship defaults to accepting the Friend Request
  def create_notification
    Notification.create(
      receiver_id: self.friend.id,
      sender_id: self.user.id,
      notifiable: self
      ) if self.accepted
  end

    Friendship.create user_id: user_id, friend_id: friend_id, accepted: true
    # Reciprocate request from other 'side' of friendship
    Friendship.create user_id: friend_id, friend_id: user_id
  end

  def self.accept_friend_request user_id, friend_id
    request = self.where(user_id: user_id, friend_id: friend_id)
    request.accepted = true
  end
end
