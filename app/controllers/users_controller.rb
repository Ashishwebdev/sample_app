class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params_new)
    if @user.save
      log_in(@user)
      flash[:successs] = "Welcome to Sample App"
      redirect_to @user
    else
      render 'new'
    end

  end

  private
  def params_new
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
