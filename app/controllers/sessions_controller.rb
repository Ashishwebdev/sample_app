class SessionsController < ApplicationController
  def new
  end

  def create

    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
    #log the user in and redirect to user show page(after creating session)
     log_in @user
     params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
     redirect_back_or @user
      else
        message = "Account not activated"
        message += " Check your email for the activation link"
        flash[:warning] =message
       #create an error message and render new page of login
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
      end
    end
  end


  def destroy
    log_out if logged_in
    redirect_to root_path
  end
end
