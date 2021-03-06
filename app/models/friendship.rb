class Friendship < ApplicationRecord
  after_create :create_notification
  
  belongs_to :user
  belongs_to :friend, class_name: "User"

  scope :accepted_friendships, -> { where(accepted: true) }
  scope :pending_friendships, -> { where(accepted: false) }
  scope :between, -> (sender_id, receiver_id){ find_by(user_id: sender_id, friend_id: receiver_id) }

  private

  def create_notification
    Notification.create(
      receiver_id: self.friend.id,
      sender_id: self.user.id,
      notifiable: self)
  end

  def self.send_friend_request user_id, friend_id
    Friendship.create user_id: user_id, friend_id: friend_id 
  end

  def self.accept_friend_request sender_id, receiver_id
    request = self.where(user_id: sender_id, friend_id: receiver_id, accepted: false)
    request.each { |req| req.accepted = true; req.save }

    # Ensure Friendship is reciprocal upon acceptance
    Friendship.create(user_id: receiver_id, friend_id: sender_id, accepted: true)
  end
end
