class ChangePostModel < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :last_commented_at, :datetime
    add_column :posts, :last_comment_user_nickname, :string
  end
end
