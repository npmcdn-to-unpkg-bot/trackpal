class UsersController < ApplicationController
  # before_action :authorize_user, :only => [:index]
  # before_action :check_for_user
  before_action :check_for_user, :except => [:new, :create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    #Users who are friends excluding self
    @user = User.find params[:id]
    # @friendship = Friendship.where(user_id: params[:id])
    fids = @current_user.friendships.pluck(:friend_id)
    fids << @current_user.inverse_friends.pluck(:user_id)
    fids = fids.flatten!
    fids = fids - [@current_user.id]
    fids.uniq!
    @friendships = User.where('id in (?)', fids)

  end

  def friends

    #Users who are not friends excluding self
    fids = @current_user.friendships.pluck(:friend_id)
    fids << @current_user.inverse_friends.pluck(:user_id)
    fids = fids.flatten!
    fids = fids + [@current_user.id]
    fids.uniq!
    @strangers = User.where('id not in (?)', fids)
  end


  def edit

    @user = @current_user

  end

  def create
    @user = User.new (user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def update
    @user = @current_user
    if params[:file].present?
      req = Cloudinary::Uploader.upload(params[:file])

      @user.image = req["url"]
      if @user.update(user_params)
        redirect_to user_path
      else
        render :edit
      end

    else
      if @user.update(user_params)
        redirect_to user_path
      else
        render :edit
      end
    end
  end

  def destroy
    user = User.find params[:id]
    user.destroy
    redirect_to root_path
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation, :image)
  end

end
