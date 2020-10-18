class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all.includes(:tasks)
  end

  def new
      @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def edit
    @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(10)
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: 'ユーザー情報を変更しました'
    else
      render :edit
    end
  end


  def destroy
    @user.destroy
    redirect_to new_user_path, notice: "アカウントを削除しました"
  end

  private

  def set_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to tasks_path
    end
  end


  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
