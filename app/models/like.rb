class Like < ApplicationRecord
  after_create :create_notification, unless: :liked_own_post?
  
  belongs_to :post
  belongs_to :user

  def create_notification
    post_creator_id = Post.find(self.post_id).user_id

    Notification.create(
      receiver_id: post_creator_id,
      sender_id: self.user_id,
      notifiable: self
    )
  end

  def liked_own_post?
    post_author_id = Post.find(self.post_id).user_id
    post_author_id == self.user_id
  end
end
