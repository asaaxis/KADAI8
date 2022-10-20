class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  skip_before_action :login_required, only: [:new, :create]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
    unless @user.id == current_user.id
      redirect_to new_user_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_url(@user), notice: "ユーザー登録しました." 
    else
      render :new
    end
  end

  def update
    if @user.id != current_user.id
      redirect_to new_user_path
    elsif @user.update(user_params)
      redirect_to user_url(@user), notice: "編集しました." 
    else
      render :edit
    end
  end

  def destroy
    if @user.id != current_user.id
      redirect_to new_user_path
    else
      @user.destroy
      redirect_to users_url, notice: "ユーザーを削除しました." 
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :image_cache)
  end
end
