class CommentsController < ApplicationController
  def create
    comment_params = params.require(:comment).permit(:text, :post_id)
    comment = Comment.new(comment_params)
    comment.user = current_user
    comment.post = Post.find(comment_params[:post_id])
    respond_to do |format|
      if comment.save
        format.html { redirect_to user_post_path(current_user, comment.post) }
        flash[:notice] = 'Comment created successfully'
      else
        format.html { redirect_to user_post_path(current_user, comment.post) }
        flash[:alert] = 'Comment not created'
      end
    end
  end
end