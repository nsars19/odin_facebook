class AlterBooleanValueInFriendshipsTable < ActiveRecord::Migration[5.2]
  def change
    rename_column :friendships, :accepted?, :accepted
  end
end
