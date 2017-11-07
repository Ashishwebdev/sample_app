class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index,:edit,:update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.where(:activated => true).paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end


  def edit
    @user = User.find(params[:id])

  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Your profile has been updated"
      redirect_to @user
    else
      render 'edit'
    end
  end


  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your mail to actiate this account"
      redirect_to root_url
    else
      render 'new'
    end

  end

def destroy
  @user = User.find(params[:id])
  @user.destroy
  flash[:success] = "User deleted"
  redirect_to users_url
end


  def User.new_token
    SecureRandom.urlsafe_base64
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in
      store_location
      flash[:danger] = "Pleas log in first"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

end
