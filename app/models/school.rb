class School < ActiveRecord::Base
  attr_accessible :city, :country, :name

  has_many :scholarships
  has_many :users, through: :scholarships

  validates :name, presence: true
  validates :country, presence: true
  validates :city, presence: true
end
