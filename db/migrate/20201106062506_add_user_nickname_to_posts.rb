class AddUserNicknameToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :user_nickname, :string
  end
end
