class TaskStatusesController < ApplicationController
  before_action :set_task_status, only: %i[ show edit update destroy ]

  def index
    @task_statuses = TaskStatus.all
  end

  def show
  end

  def new
    @task_status = TaskStatus.new
  end

  def edit
  end

  def create
    @task_status = TaskStatus.new(task_status_params)

    respond_to do |format|
      if @task_status.save
        format.html { redirect_to @task_status, notice: "Task status was successfully created." }
        format.json { render :show, status: :created, location: @task_status }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task_status.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task_status.update(task_status_params)
        format.html { redirect_to @task_status, notice: "Task status was successfully updated." }
        format.json { render :show, status: :ok, location: @task_status }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task_status.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task_status.destroy!

    respond_to do |format|
      format.html { redirect_to task_statuses_path, status: :see_other, notice: "Task status was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_status
      @task_status = TaskStatus.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_status_params
      params.require(:task_status).permit(:name, :position, :state, :color)
    end
end
