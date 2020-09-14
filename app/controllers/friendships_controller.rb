class FriendshipsController < ApplicationController
  def create
    receiver_id = params[:user_id]
    sender_id = current_user.id

    Friendship.send_friend_request(sender_id, receiver_id) unless already_requested?

    respond_to do |format|
      format.js { render inline: "location.reload();" }
    end
  end

  def accept_friend_request
    Friendship.accept_friend_request(params[:friend_id], params[:user_id])
    
    respond_to do |format|
      format.js { render inline: "location.reload();" }
    end
  end

  private

  def already_requested?
    receiver_id = params[:user_id]
    sender_id = current_user.id

    Friendship.where(friend_id: receiver_id, user_id: sender_id).any?
  end
end
