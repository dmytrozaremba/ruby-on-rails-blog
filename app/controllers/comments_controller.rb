class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    @comment.user = current_user
    redirect_to article_path(@article) if @comment.save
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])

    if @comment.user != current_user
      flash[:alert] = 'Not authorized'
      redirect_to @article
      return
    end

    flash[:notice] = 'Comment has been deleted'

    @comment.destroy
    redirect_to article_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
