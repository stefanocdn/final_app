class CategoriesController < ApplicationController

  def index
    @categories = Category.order(:name)
	respond_to do |format|
	  format.html
	  format.json { render json: @categories.tokens(params[:q]) }
	end
	# else
	#   @categories = Category.order(:name).where("name like ?", "%#{params[:term]}%")
 #  	  render json: @categories.map(&:name)
 #  	end
  end
end