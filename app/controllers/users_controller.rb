class UsersController < ApplicationController

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
    @user = User.new
    @user.username = params[:username]
    @user.first_name = params[:first_name]
    @user.last_name = params[:last_name]
    @user.password_digest = params[:password_digest]
    @user.facebook_access_token = params[:facebook_access_token]
    @user.facebook_id = params[:facebook_id]
    
    if @user.save
      redirect_to users_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    @user.username = params[:username]
    @user.first_name = params[:first_name]
    @user.last_name = params[:last_name]
    @user.password_digest = params[:password_digest]
    @user.facebook_access_token = params[:facebook_access_token]
    @user.facebook_id = params[:facebook_id]
    
    if @user.save
      redirect_to users_url
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
    redirect_to users_url
  end
end
