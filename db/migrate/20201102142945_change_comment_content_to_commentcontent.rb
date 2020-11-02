class ChangeCommentContentToCommentcontent < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :content
    add_column :comments, :comment_content, :string
  end
end
