class PostsController < ApplicationController
  def index
    @posts = Post.all
    render :index
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to posts_url
    else
      render :index
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end