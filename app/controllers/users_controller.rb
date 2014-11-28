class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]

  def show

  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You're registered."
      redirect_to root_path
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your profile was updated."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

# Commented out. Keeping this as reference method to friend and unfriend.
# Course 2 week 3. Post vote video minute 13 will explain this non model back form.
  # def befriend
  #   user = User.find(params[:id])    
  #   if user
  #     current_user.followings << user
  #     flash[:notice] = "You are now friend of #{user.username}."
  #     redirect_to user_path(user)
  #   else
  #     flash[:error] = "Unable to add friend."
  #     redirect_to root_path
  #   end      
  # end

  # def unfriend
  #   user = User.find(params[:id])
  #   rel = Friendship.where(follower: current_user, leader: user).first
  #   if user && rel
  #     rel.destroy
  #     flash[:notice] = "You are no longer following #{user.username}."
  #     redirect_to user_path(user)
  #   else
  #     flash[:error] = "Unable to unfriend."
  #     redirect_to root_path      
  #   end
  # end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email, :id)
  end

  def set_user  
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:error] = "You're not allowed to do that."
      redirect_to root_path
    end
  end
end
















