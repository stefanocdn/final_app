class Language < ActiveRecord::Base
  attr_accessible :name

  has_many :speakings
  has_many :users, through: :speakings

  validates :name, presence: true
end
