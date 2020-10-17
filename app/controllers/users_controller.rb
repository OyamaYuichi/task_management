class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]

  def new
    if logged_in?
      flash[:notice] = '既にアカウントをお持ちです'
      redirect_to tasks_path
    end
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

  def show
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
