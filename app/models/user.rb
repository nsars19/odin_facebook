class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :sent_requests, class_name: "Friendship"
  has_many :received_requests, class_name: "Friendship", foreign_key: :friend_id
  has_many :accepted_friendships, -> { Friendship.accepted_friendships }, class_name: "Friendship"
  has_many :pending_friendships, -> { Friendship.pending_friendships }, class_name: "Friendship"
  has_many :friends, through: :accepted_friendships
  has_many :posts
  has_many :likes
  has_many :comments
  has_many :notifications, foreign_key: :receiver_id
end
