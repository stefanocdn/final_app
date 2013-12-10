class CompaniesController < ApplicationController

  def index
	@companies = Company.order(:name).where("name ilike ?", "%#{params[:term]}%")
	render json: @companies.map(&:name)
  end
end