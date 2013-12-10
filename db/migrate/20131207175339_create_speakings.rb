class CreateSpeakings < ActiveRecord::Migration
  def change
    create_table :speakings do |t|
      t.integer :user_id
      t.integer :language_id

      t.timestamps
    end
    add_index :speakings, :user_id
    add_index :speakings, :language_id
    add_index :speakings, [:user_id, :language_id], unique: true
  end
end
