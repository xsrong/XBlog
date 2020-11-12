class AddUserNicknameToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :user_nickname, :string
  end
end
