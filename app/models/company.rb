class Company < ActiveRecord::Base
  attr_accessible :name

  has_many :positions
  has_many :users, through: :positions

  validates :name, presence: true
end
