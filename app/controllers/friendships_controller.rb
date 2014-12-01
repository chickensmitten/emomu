class FriendshipsController < ApplicationController
  before_action :require_user, only: [:create, :destroy]  

  def index

  end

  def create
    @user = current_user.leader_friendships.build(follower_id: current_user.id, leader_id: params[:user_id])
    if @user.save
      flash[:notice] = "Added friend."
      redirect_to root_path
    else
      flash[:error] = "Unable to add friend."
      redirect_to :back
    end
  end

  def destroy
    @friendship = Friendship.where(follower: current_user, leader: params[:user_id]).first
    if @friendship.destroy
      flash[:notice] = "Removed friendship."
      redirect_to root_path
    else
      flash[:error] = "Unable to remove friend."
      redirect_to :back
    end
  end

end