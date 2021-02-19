class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def update
    if @article.update(article_params_whitelist)
      flash[:notice] = "Article was updated successfully"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def create
    @article = Article.new(article_params_whitelist)
    @article.user = User.first
    if @article.save
      flash[:notice] = "Article was created successfully."
      redirect_to @article
    else
      render 'new'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end

  def article_params_whitelist
    params.require(:article).permit(:title, :content)
  end
end

# We are using @ to make instance variables so that they can be accessed by the views.