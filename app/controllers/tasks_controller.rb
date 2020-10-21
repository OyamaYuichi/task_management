class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :show, :destroy]
  def index
    if logged_in?
      @labels = Label.where(user_id: nil).or(Label.where(user_id: current_user.id))
      if params[:sort_expired]
        @tasks = current_user.tasks.order(deadline: :desc).page(params[:page]).per(10)
      elsif params[:sort_priority]
        @tasks = current_user.tasks.order(priority: :asc).page(params[:page]).per(10)
      else
        @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(10)
      end

      if params[:search].present?
        if params[:name].present? && params[:status].present?
          @tasks = current_user.tasks.get_by_name(params[:name]).get_by_status(params[:status]).page(params[:page]).per(10)
        elsif params[:label].present?
          @tasks = current_user.tasks.get_by_label(params[:label]).page(params[:page]).per(10)
        elsif params[:name].present?
            @tasks = current_user.tasks.get_by_name(params[:name]).page(params[:page]).per(10)
        elsif params[:status].present?
            @tasks = current_user.tasks.get_by_status(params[:status]).page(params[:page]).per(10)
        end
      end
    else
      flash[:notice] = 'ログインしてください'
      redirect_to new_session_path
    end
  end

  def new
    @task = Task.new
    @label = @task.labelings.build
    @labels = Label.where(user_id: nil).or(Label.where(user_id: current_user.id))
    # @labels = Label.all
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new
    end
  end


  def edit
    @labels = Label.where(user_id: nil).or(Label.where(user_id: current_user.id))
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'Task was successfully destroyed.'
  end




  private

  def set_task
    if current_user.admin?
      @task = Task.find(params[:id])
    else
      @task = current_user.tasks.find(params[:id])
    end
  end

  def task_params
    params.require(:task).permit(:name, :detail, :deadline, :status, :priority, label_ids: [])
  end
end
