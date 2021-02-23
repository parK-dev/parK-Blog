class CategoriesController < ApplicationController

  def new
    @category = Category.new
  end
  
  def index

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

end