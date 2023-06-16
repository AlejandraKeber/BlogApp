class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def new
    post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: post } }
    end
  end

  def create
    post_params = params.require(:post).permit(:title, :text)
    post = Post.new(post_params)
    post.user = current_user
    comments_counter = 0
    likes_counter = 0
    respond_to do |format|
      if post.save
        format.html { redirect_to user_post_path(current_user, post) }
        flash[:notice] = 'Post created successfully'
      else
        format.html { render :new, locals: { post: post } }
        flash[:alert] = 'Post not created'
      end
    end
  end
end
