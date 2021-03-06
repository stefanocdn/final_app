class Review < ActiveRecord::Base
  attr_accessible :content, :reviewed_id, :rating
  default_scope order: 'reviews.created_at DESC'
  scope :recommendations, lambda { where('rating >= ?', 4) }

  belongs_to :reviewer, class_name: "User"
  belongs_to :reviewed, class_name: "User"

  validates :reviewed_id, presence: true
  validates :reviewer_id, presence: true
  validates :content, presence: true
  validates :rating, presence: true
end
