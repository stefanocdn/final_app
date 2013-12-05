class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.text :content
      t.decimal :price
      t.integer :user_id
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
    add_index :lessons, [:user_id, :created_at]
    add_index :lessons, [:user_id, :price]
  end
end
