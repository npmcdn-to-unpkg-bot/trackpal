class UsersController < ApplicationController
  # before_action :authorize_user, :only => [:index]
  # before_action :check_for_user
  before_action :check_for_user, :except => [:new, :create]

  def index
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find params[:id]
    @friends = Friendship.where(@user)

  end

  def edit

    @user = @current_user

  end

  def create
    @user = User.new (user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path
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
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end

end
