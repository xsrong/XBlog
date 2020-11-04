class AddLastCommentInfoToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :last_comment_id, :integer
    add_column :posts, :last_comment_user_id, :integer
  end
end
