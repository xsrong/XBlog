class ChangePasswordDigestToSalt < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :password_digest
    add_column :users, :password_salt, :string
  end
end
