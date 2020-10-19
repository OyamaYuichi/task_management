class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_admin

  def index
    @users = User.all.includes(:tasks)
    # @users = User.where(admin: false).includes(:tasks)
  end

  def new
      @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user.id), notice: "ユーザー「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def show
    @tasks = @user.tasks.order(created_at: :desc).page(params[:page]).per(5)
  end


  def edit
    @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(5)
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id), notice: 'ユーザー情報を変更しました'
    else
      render :edit
    end
  end


  def destroy
    if @user.destroy
      redirect_to admin_users_url, notice: "アカウントを削除しました"
    else
      redirect_to admin_users_path, notice: "最低一人の管理者が必要なため#{@user.name}さんを削除できません"
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end


  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def require_admin
    redirect_to root_path, notice: "アクセス権限がありません" unless current_user.admin?
  end

end
