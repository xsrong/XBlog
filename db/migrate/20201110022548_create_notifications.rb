class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.string :user_nickname
      t.integer :mentioned_user_id
      t.string :mentioned_user_nickname
      t.string :mentioned_data_type
      t.integer :mentioned_data_id
      t.string :content

      t.timestamps
    end
  end
end
