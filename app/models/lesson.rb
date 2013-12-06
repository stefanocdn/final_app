class Lesson < ActiveRecord::Base
  attr_accessible :address, :content, :latitude, 
    :longitude, :price, :title, :category_tokens

  scope :recent, order('lessons.created_at DESC')
  scope :with_address, where('longitude IS NOT ? AND latitude IS NOT ?', nil, nil)
  # Geocoding
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  reverse_geocoded_by :latitude, :longitude, :address => :address
  after_validation :reverse_geocode 

  belongs_to :user
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations
  attr_reader :category_tokens

  include PgSearch
  pg_search_scope :search, against: [:title, :content, :address],
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

  # Tagging methods
  def self.tagged_with(name)
    Category.find_by_name!(name).lessons
  end

  def self.tag_counts
    Category.select("categories.id, categories.name, count(categorizations.category_id) as count").
      joins(:categorizations).group("categorizations.category_id, categories.id, categories.name")
  end
  
  def tag_list
    categories.map(&:name).join(", ")
  end
end