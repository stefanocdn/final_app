class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.string :subject
      t.text :body
      t.boolean :sent
      t.integer :sender_id
      t.integer :recipient_id

      t.timestamps
    end
    add_index :messages, :user_id
    add_index :messages, :subject
    add_index :messages, [:user_id, :subject]
    add_index :messages, :sender_id
    add_index :messages, :recipient_id
  end
end
