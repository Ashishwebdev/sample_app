class PasswordResetsController < ApplicationController
  def new
  end

  def edit
  end

  def create

    @user = User.find_by_email(params[:password_reset][:email])
    if @user
      @user.create_reset_digest
      @user.sent_password_reset_email
      flash[:info] = "check your email for password reset details"
      redirect_to root_url
    else
      flash.now[:danger] = "Email not found"
      render 'new'
    end
  end
end