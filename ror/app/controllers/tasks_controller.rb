class TasksController < ApplicationController
  layout "dashboard"

  before_action :set_task, only: %i[show edit update destroy]
  before_action :initialize_task, only: %i[new create]

  def index
    @tasks = Task.all

    authorize @tasks
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if @task.save
      redirect_to @task.board, notice: "Task was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: "Task was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy

    redirect_to tasks_url, notice: "Task was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])

      authorize @task
    end

    def initialize_task
      if task_params[:board_id].nil?
        redirect_to tasks_url, alert: "Board must be set when creating a task."
        return
      end

      @task = Task.new(creator: current_user, **task_params)

      authorize @task
    end

    # Only allow a list of trusted parameters through.
    def task_params
      return {} unless params[:task].present?

      params.require(:task).permit(:title, :status, :board_id, :task_status_id, :assignee_id)
    end
end
