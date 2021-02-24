class CategoriesController < ApplicationController

  before_action :require_admin, except: [:index, :show]
  
  def new
    @category = Category.new
  end
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: 10)
  end

  def show
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params_whitelist)
    if @category.save
      flash[:notice] = "Category successfully created."
      redirect_to @category
    else
      render 'new'
    end
  end

  private

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