class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :receiver_id
      t.integer :sender_id
      t.boolean :read, default: false
      t.datetime :read_at, default: nil
      t.references :notifiable, polymorphic: true
      
      t.timestamps
    end
  end
end
