class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[facebook]

  has_one_attached :avatar
  has_many :sent_requests, class_name: "Friendship"
  has_many :received_requests, class_name: "Friendship", foreign_key: :friend_id
  has_many :accepted_friendships, -> { Friendship.accepted_friendships }, class_name: "Friendship"
  has_many :pending_friendships, -> { Friendship.pending_friendships }, class_name: "Friendship"
  has_many :friends, through: :accepted_friendships
  has_many :posts
  has_many :likes
  has_many :comments
  has_many :notifications, foreign_key: :receiver_id

  def likes? post
    likes = Like.where(user_id: self.id, post_id: post.id)
    likes.any?
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.avatar = auth.info.image
      # user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
