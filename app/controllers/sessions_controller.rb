class SessionsController < ApplicationController
  def new
  end
<<<<<<< HEAD
  
=======

>>>>>>> static
  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
<<<<<<< HEAD
      flash.now[:error] = 'Invalid email/password combination'
=======
      flash.now[:danger] = 'Invalid email/password combination'
>>>>>>> static
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
