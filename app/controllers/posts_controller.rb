class PostsController < ApplicationController
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
end
