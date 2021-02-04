class ArticlesController < ApplicationController

  def show
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

end

# We are using @ to make instacne variables so that they can be accessed by the views.