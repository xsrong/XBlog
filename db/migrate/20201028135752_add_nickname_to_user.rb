class AddNicknameToUser < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
    add_column :users, :nickname, :string
  end
end
