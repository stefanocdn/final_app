class Lesson < ActiveRecord::Base
  attr_accessible :address, :content, :latitude, 
    :longitude, :price, :title, :category_tokens

  # Geocoding
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  belongs_to :user
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations
  attr_reader :category_tokens

  include PgSearch
  pg_search_scope :search, against: [:title, :content],
  using: {tsearch: {dictionary: "english"}},
  associated_against: {categories: [:name]},
  :using => {:tsearch => {:prefix => true}}

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates :content, presence: true
  validates :price, presence: true
  # validates :category_tokens, presence: true

  def category_tokens=(tokens)
    self.category_ids = Category.ids_from_tokens(tokens)
  end
  
  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end
end