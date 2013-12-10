class Speaking < ActiveRecord::Base
  attr_accessible :language_id

  belongs_to :user
  belongs_to :language

  validates :user_id, presence: true
  validates :language_id, presence: true

  def language_name
  	language.try(:name)
  end

  def language_name=(name)
  	self.language = Language.find_or_create_by_name(name) if name.present?
  end
end
