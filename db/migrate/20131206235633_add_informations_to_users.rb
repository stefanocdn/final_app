class AddInformationsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :summary, :text
    add_column :users, :gender, :string
    add_index :users, :gender
  end
end
