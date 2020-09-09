class CommentsController < ApplicationController
  def create
    comment = params[:comment][:comment]
    @comment = Comment.new(
      post_id: params[:post_id],
      user_id: current_user.id,
      text: comment
    )

    respond_to do |format|
      if @comment.save
        format.js { render inline: "location.reload();" }
      end
    end
  end
end
