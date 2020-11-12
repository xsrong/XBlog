class AddToUserToLikes < ActiveRecord::Migration[6.0]
  def change
    add_column :likes, :to_user_id, :integer
  end
end
