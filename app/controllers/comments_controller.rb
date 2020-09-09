class CommentsController < ApplicationController
  def create
    comment = params[:comment][:comment]
    @comment = Comment.new(
      post_id: params[:post_id],
      user_id: current_user.id,
      text: comment
    )

    if @comment.save
      redirect_back(fallback_location: 'posts/index')
    end
  end
end
