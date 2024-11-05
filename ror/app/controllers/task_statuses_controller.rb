class TaskStatusesController < DashboardController
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

    respond_to do |format|
      if @task_status.save
        format.html { redirect_to @task_status, notice: "Task status was successfully created." }
        format.json { render json: @task_status, status: :created, location: @task_status }
      else
        format.html { render :new }
        format.json { render json: @task_status.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @task_status

    respond_to do |format|
      if @task_status.update(task_status_params)
        format.html { redirect_to @task_status, notice: "Task status was successfully updated." }
        format.json { render json: @task_status, status: :ok, location: @task_status }
      else
        format.html { render :edit }
        format.json { render json: @task_status.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @task_status

    @task_status.destroy
    respond_to do |format|
      format.html { redirect_to task_statuses_url, notice: "Task status was successfully destroyed." }
      format.json { head :no_content }
    end
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
