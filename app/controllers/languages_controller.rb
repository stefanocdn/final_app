class LanguagesController < ApplicationController

  def index
	@languages = Language.order(:name).where("name ilike ?", "%#{params[:term]}%")
	render json: @languages.map(&:name)
  end
end