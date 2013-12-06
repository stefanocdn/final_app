class AddLocalizationAttributesToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :city, :string
    add_column :lessons, :state, :string
    add_column :lessons, :state_code, :string
    add_column :lessons, :postal_code, :string
    add_column :lessons, :country, :string
    add_column :lessons, :country_code, :string
  end
end
