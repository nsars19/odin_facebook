class UsersController < ApplicationController
  def index
    @users = User.all.reject { |user| user == current_user } - 
      current_user.friends -
      current_user.pending_friendships.map do |request|
          User.find request.friend_id
        end
  end

  def show
    @user = User.find params[:id]
    @posts = @user.posts
  end
end
