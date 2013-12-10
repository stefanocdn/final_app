class Position < ActiveRecord::Base
  attr_accessible :city, :company_id, :country, :end_date, :start_date

  belongs_to :user
  belongs_to :company

  default_scope -> { order('end_date DESC') }

  validates :user_id, presence: true
  validates :company_id, presence: true
  validates :country, presence: true
  validates :city, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  def company_name
  	company.try(:name)
  end

  def company_name=(name)
  	self.company = Company.find_or_create_by_name(name) if name.present?
  end
end
