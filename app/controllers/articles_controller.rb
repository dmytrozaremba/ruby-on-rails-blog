class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show index]

  def index
    @articles = Article.where(['user_id = ? or status = ?',
                               current_user, 'public']).search(params[:search]).order('created_at DESC').page(params[:page]).per_page(2)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.user != current_user
      flash[:alert] = 'Not authorized'
      redirect_to @article
      return
    end

    if @article.update(article_params)
      flash[:notice] = 'Article has been updated'
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])

    if @article.user != current_user
      flash[:alert] = 'Not authorized'
      redirect_to @article
      return
    end

    flash[:notice] = 'Article has been deleted'
    @article.destroy

    redirect_to root_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :status)
  end
end
