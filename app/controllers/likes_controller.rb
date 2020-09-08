class LikesController < ApplicationController
  def create
    like_params = {
      user_id: current_user.id,
      post_id: params[:post_id]
    }

    @like = Like.new(like_params)

    @like.save 
  end

  def destroy
    @like = Like.where(user_id: current_user.id, post_id: params[:post_id])

    @like.first.destroy
  end
end
