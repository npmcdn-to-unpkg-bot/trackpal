class UsersController < ApplicationController
  def index
  end

  def new

  end

  def show
    @friends = Friendship.where(params[:user_id])
    
  end

  def edit

  end


end
