class FeelingsController < ApplicationController
  before_action :require_user, only: [:new, :create]


  def new
    @feeling = Feeling.new
  end

  def create
    @feeling = Feeling.new(feeling_params)

    if @feeling.save
      flash[:notice] = "You have created a new Feel. ;)"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @feeling = Feeling.find(params[:id])
    @pages = @feeling.posts.order(created_at: :desc)
    @post = @pages.paginate(:page => params[:page], :per_page => 5)   
  end

  private

  def feeling_params
    params.require(:feeling).permit(:name)
  end

end