require 'open-uri'

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
        begin
        url = "https://graph.facebook.com/me/home?access_token=#{@user.facebook_access_token}&limit=200"
        raw_response = open(url).read
        parsed_response = JSON.parse(raw_response)
        @posts = parsed_response['data'].select { |p| p['type'] == 'video' }
      rescue
        flash[:error] = "You must re-authorize facebook"
        @posts = []
      end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
    if @user.save
      format.html { redirect_to @user, notice: "User Successfully Created"}
      format.json { render action: 'show', status: :created, location: @user }
    else
      format.html { render action: 'new' }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    repsond_to do |format|
    if @user.update(user_params)
      format.html { redirect_to @user, notice: "User was successfully updated." }
      format.json { head no_content }
    else
      format.html { render action: 'edit' }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
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
