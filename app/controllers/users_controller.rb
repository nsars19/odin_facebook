class UsersController < ApplicationController
  def index
    @users = User.all.reject { |user| user == current_user }
  end

  def show
    @user = User.find params[:id]
    @posts = @user.posts
  end
end
