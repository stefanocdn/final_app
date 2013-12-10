class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.integer :user_id
      t.integer :company_id
      t.date :start_date
      t.date :end_date
      t.string :city
      t.string :country

      t.timestamps
    end
    add_index :positions, :user_id
    add_index :positions, :company_id
    add_index :positions, [:user_id, :company_id]
  end
end
