class LikesController < ApplicationController
  def create
    like_params = {
      user_id: current_user.id,
      post_id: params[:post_id]
    }

    @like = Like.new(like_params)

    respond_to do |format|
      if @like.save
        format.js { render inline: "location.reload();" }
      end
    end
  end

  def destroy
    @like = Like.where(user_id: current_user.id, post_id: params[:post_id])

    @like.first.destroy
  end
end
