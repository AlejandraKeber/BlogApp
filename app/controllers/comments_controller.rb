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

    def destroy
      @comment = Comment.find(params[:id])
      @post = Post.find(@comment.post_id)
      if can?(:destroy, @comment)
        @comment.destroy
        @post.update_comments_counter
        redirect_to user_post_path(@user.id, @post.id), notice: 'Comment was successfully deleted.'
      else
        redirect_to user_post_path(@user.id, @post.id), alert: 'You are not authorized to delete this comment.'
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :post_id)
  end
end
