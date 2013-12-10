class CategoriesController < ApplicationController

  def index
    @categories = Category.order(:name)
	respond_to do |format|
	  format.html
	  format.json { render json: @categories.tokens(params[:q]) }
	end
  end

  def search_suggestion
	@categories = Category.order(:name).where("name ilike ?", "%#{params[:term]}%")
    render json: @categories.map(&:name)
  end
end