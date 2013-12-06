class AddIndexToLessons < ActiveRecord::Migration
  def change
  	add_index :lessons, [:latitude, :longitude]
  end
end
