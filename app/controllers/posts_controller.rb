class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :show, :update]
  before_action :require_user, except: [:show, :index]
  before_action :require_creator, only: [:edit, :update, :destroy]

  def index
    @posts = Post.paginate(:page => params[:page], :per_page => 5)
  end

  def show
    @posts = Post.paginate(:page => params[:page], :per_page => 5)    
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user
    if @post.save
      @post.create_activity :create, owner: current_user #from Public Activity gem. Using Common in Post Model.
      flash[:notice] = "Your post was created."
      redirect_to posts_path
    else
      render :new
    end
  end 

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "This post was updated."
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy

  end

  private

  def post_params
    params.require(:post).permit(:url, :description, feeling_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def require_creator
    access_denied unless logged_in? and (current_user == @post.creator || current_user.admin?)
  end

end
















