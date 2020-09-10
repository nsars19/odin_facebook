class FriendshipsController < ApplicationController
  def create
    receiver_id = params[:user_id]
    sender_id = current_user.id

    Friendship.send_friend_request(sender_id, receiver_id) unless already_requested?

    respond_to do |format|
      format.js { render inline: "location.reload();" }
    end
  end
end
