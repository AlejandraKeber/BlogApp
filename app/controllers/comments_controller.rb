class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post = Post.find(params[:comment][:post_id])
    @comment.user_id = current_user.id
    @comment.post.author_id = current_user.id

    if @comment.save
      redirect_to user_post_path(@comment.post.author_id, @comment.post_id)
    else
      redirect_to user_post_path(@comment.post.author_id, params[:comment][:post_id])
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :post_id)
  end
end
