class RemoveCommentIdColumnFromLikes < ActiveRecord::Migration[5.2]
  def change
    remove_column :likes, :comment_id
  end
end
