class PostsController < ApplicationController
  # before_action :require_login
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authorize_post, only: %i[ edit update destroy ]

  def index
    # @posts = Post.all.order(created_at: :desc)
    @posts = Post.all.includes(:user)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params.merge(user: current_user))
      redirect_to @post, notice: "Post updated successfully."
    else
      render :edit
    end
  end



  def destroy
    @post.destroy
    redirect_to posts_url, notice: "Post was successfully destroyed."
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content)
    end

    def authorize_post
      redirect_to posts_path, alert: "You are not authorized to modify this post." unless @post.user == current_user
    end
end
