class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :current_user_must_be_user, only: [:show, :edit, :update, :destroy]

  def current_user_must_be_user
    unless current_user == @user
      redirect_to :back, notice: "You are not authorized for that"
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "User Created Successfully"
      redirect_to users_url
    else
      flash[:error] = "Something went wrong, please try again"
      render 'new'
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update

    if @user.update(user_params)
      flash[:notice] = "User Successfully Updated"
      redirect_to users_url
    else
      flash[:error] = "Something went wrong, please try again"
      render 'new'
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
    redirect_to users_url
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:username, :first_name, :last_name, :password, :password_confirmation, :facebook_access_token, :facebook_id)
  end
end
