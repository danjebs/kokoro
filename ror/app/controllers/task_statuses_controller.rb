class TaskStatusesController < ApplicationController
  before_action :set_task_status, only: %i[show edit update destroy]
  before_action :authorize_task_status, only: %i[show edit update destroy]

  def index
    authorize TaskStatus

    @task_statuses = TaskStatus.all
  end

  def show
    authorize @task_status
  end

  def new
    authorize TaskStatus

    @task_status = TaskStatus.new
  end

  def edit
    authorize @task_status
  end

  def create
    authorize @task_status

    @task_status = TaskStatus.new(task_status_params)

    if @task_status.save
      redirect_to @task_status, notice: 'Task status was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @task_status

    if @task_status.update(task_status_params)
      redirect_to @task_status, notice: 'Task status was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @task_status

    @task_status.destroy
    redirect_to task_statuses_url, notice: 'Task status was successfully destroyed.'
  end

  private

  def set_task_status
    @task_status = TaskStatus.find(params[:id])
  end

  def authorize_task_status
    authorize @task_status
  end

  def task_status_params
    params.require(:task_status).permit(:name, :board_id)
  end
end
