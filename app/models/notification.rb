class Notification < ApplicationRecord
  after_find :mark_as_read
  
  belongs_to :receiver, class_name: "User"
  belongs_to :sender, class_name: "User"
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(read_at: nil) }

  private

  def mark_as_read
    self.read = true
    self.read_at = DateTime.now
    self.save
  end
end
