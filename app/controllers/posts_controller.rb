class PostsController < ApplicationController
  def index
    @posts = (current_user.posts + get_friends_posts)
             .sort_by(&:created_at)
             .reverse
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    
    if @post.save
      redirect_to home_path
    else
      render home_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

  def get_friends_posts
    Post.where(user_id: current_user.friends.ids)
  end
end
