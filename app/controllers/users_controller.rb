class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :require_same_user]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params_whitelist)
    if @user.save 
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the blog, #{@user.username}! You have succesfully registered and are ready to start writing."
      redirect_to articles_path      
    else
      render 'new'    
    end
  end

  def edit
  end

  def update
    if @user.update(user_params_whitelist)
      flash[:notice] = "Your profile was successfully updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 10)

  end

  def destroy 
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "The account and its posts have been successfully deleted."
    redirect_to @user
  end

  private

  def user_params_whitelist
    params.require(:user).permit(:username, :email, :about, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own account"
      redirect_to @user
    end
  end

end