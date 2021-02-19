class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params_whitelist)
    if @user.save 
      flash[:notice] = "Welcome to the blog, #{@user.username}! You have succesfully registered and are ready to start writing."
      redirect_to articles_path      
    else
      render 'new'    
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params_whitelist)
      flash[:notice] = "Your profile was successfully updated"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles
  end

  private

  def user_params_whitelist
    params.require(:user).permit(:username, :email, :password)
  end

end