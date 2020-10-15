class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :show, :destroy]
  def index
    if params[:sort_expired]
      @tasks = Task.all.order(deadline: :desc)
    elsif params[:sort_priority]
      @tasks = Task.all.order(priority: :asc)
    else
      @tasks = Task.all.order(created_at: :desc)
    end

    if params[:search].present?
      if params[:name].present? && params[:status].present?
        @tasks = Task.get_by_name(params[:name]).get_by_status(params[:status])
      elsif params[:name].present?
          @tasks = Task.get_by_name(params[:name])
      elsif params[:status].present?
          @tasks = Task.get_by_status(params[:status])
      end
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new
    end
  end


  def edit
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
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :detail, :deadline, :status, :priority)
  end
end
