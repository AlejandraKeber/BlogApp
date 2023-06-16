class LikesController < ApplicationController
  def create
    like_params = params.require(:like).permit(:post_id)
    like = Like.new(like_params)
    like.user = current_user
    like.post = Post.find(like_params[:post_id])
    respond_to do |format|
      format.html { redirect_to user_post_path(current_user, like.post) }
      if like.save
        flash[:notice] = 'Like created successfully'
      else
        flash[:alert] = 'Like not created'
      end
    end
  end
end
