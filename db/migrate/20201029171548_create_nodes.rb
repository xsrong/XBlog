class CreateNodes < ActiveRecord::Migration[6.0]
  def change
    create_table :nodes do |t|
      t.string :name

      t.timestamps
    end
    add_column :posts, :node_id, :integer, default: 1
  end
end