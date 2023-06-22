class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.includes(posts: [:comments]).find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.comments_counter = 0
    @post.likes_counter = 0
    if @post.save
      @post.update_comments_counter
      redirect_to user_post_path(current_user, @post)
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if can?(:destroy, @post) # Check if the current user is authorized to delete the post
      @post.likes.destroy_all
      @post.comments.destroy_all
      @post.destroy
      @user.update_posts_counter
      redirect_to user_posts_path(user_id: @user.id), notice: 'Post was successfully deleted.'
    else
      redirect_to user_post_path(user_id: @user.id, id: @post.id), alert: 'You are not authorized to delete this post.'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
