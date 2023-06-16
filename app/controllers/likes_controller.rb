class LikesController < ApplicationController
  def create
    like_params = params.require(:like).permit(:post_id)
    like = Like.new(like_params)
    like.user = current_user
    like.post = Post.find(like_params[:post_id])
    respond_to do |format|
      if like.save
        like.increment_post_likes_counter
        format.html { redirect_to user_post_path(current_user, like.post) }
        flash[:notice] = 'Like created successfully'
      else
        format.html { redirect_to user_post_path(current_user, like.post) }
        flash[:alert] = 'Like not created'
      end
    end
  end
end