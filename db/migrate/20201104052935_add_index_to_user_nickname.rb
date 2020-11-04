class AddIndexToUserNickname < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :nickname
  end
end
