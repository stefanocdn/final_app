class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :city
      t.string :country

      t.timestamps
    end
    add_index :schools, :name
    add_index :schools, :city
    add_index :schools, :country
  end
end
