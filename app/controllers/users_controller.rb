class UsersController < ApplicationController
  before_filter :signed_in_user,
                only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  def index
    @users = User.text_search(params[:search]).paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def show
    @user = User.find(params[:id])
    @lessons = @user.lessons.paginate(page: params[:page]).per_page(4)
    @reverse_reviews = @user.reverse_reviews.paginate(page: params[:page]).per_page(4)
    @reviews = @user.reviews.paginate(page: params[:page]).per_page(4)
    @scholarships = @user.scholarships
    @positions = @user.positions
    @languages = @user.languages
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    @scholarships = @user.scholarships
    @positions = @user.positions
    @languages = @user.languages
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
