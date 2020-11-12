class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.integer :from_user_id
      t.string :from_user_nickname
      t.integer :to_user_id
      t.string :to_user_nickname
      t.string :content
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
