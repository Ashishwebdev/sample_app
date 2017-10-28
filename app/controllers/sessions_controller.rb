class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
    #log the user in and redirect to user show page(after creating session)
     log_in user
      redirect_to user
    else
    #create an error message and render new page of login
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end


  def destroy
    log_out
    redirect_to root_path
  end
end
