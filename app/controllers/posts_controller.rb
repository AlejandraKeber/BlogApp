class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    Comment.new
    Like.new
  end

  def new
    post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: } }
    end
  end

  def create
    post_params = params.require(:post).permit(:title, :text)
    post = Post.new(post_params)
    post.user = current_user
    respond_to do |format|
      if post.save
        format.html { redirect_to user_post_path(current_user, post) }
        flash[:notice] = 'Post created successfully'
      else
        format.html { render :new, locals: { post: } }
        flash[:alert] = 'Post not created'
      end
    end
  end
end
