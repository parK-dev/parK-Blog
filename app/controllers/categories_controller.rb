class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :show, :destroy]
  before_action :require_admin, except: [:index, :show]
  
  def new
    @category = Category.new
  end
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: 10)
  end

  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def create
    @category = Category.new(category_params_whitelist)
    if @category.save
      flash[:notice] = "Category successfully created."
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def update
    if @category.update(category_params_whitelist)
      flash[:notice] = "Category name changed successfully"
      redirect_to @category
    else
      render 'edit'
    end
  end

  def edit
  end

  def destroy 
    @category.destroy
    flash[:notice] = "The category has been successfully deleted."
    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params_whitelist
    params.require(:category).permit(:name)
  end

  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "This action requires administrator permissions"
      redirect_to categories_path
    end
  end
end