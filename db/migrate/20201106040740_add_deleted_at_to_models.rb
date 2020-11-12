class AddDeletedAtToModels < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :deleted_at, :datetime
    add_column :posts, :deleted_at, :datetime
    add_column :comments, :deleted_at, :datetime
    add_index :posts, :title
  end
end
