class ChangeCommentContentToContent < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :comment_content
    add_column :comments, :content, :string
  end
end
