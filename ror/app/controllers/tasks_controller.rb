class TasksController < DashboardController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :initialize_task, only: %i[new create]
  before_action :set_breadcrumbs, only: %i[index new show edit update]

  def index
    @tasks = Task.accessible_by(current_user)

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
      redirect_to @task, notice: "Task was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    position = task_params[:position].present? ? task_params[:position].to_i : nil

    respond_to do |format|
      if @task.update(task_params)
        @task.insert_at(position) if position

        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.json { render json: @task, status: :ok, location: @task }
      else
        format.html { render render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    board = @task.board

    @task.destroy

    redirect_to board, notice: "Task was successfully destroyed."
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

      params.require(:task).permit(:title, :task_status_id, :position, :board_id, :assignee_id)
    end

    def set_breadcrumbs
      if action_name == "index"
        add_breadcrumb("Tasks", tasks_path)
      else
        add_breadcrumb("Boards", boards_path)
        add_breadcrumb(@task.board.name, @task.board)

        if action_name == "new"
          add_breadcrumb("New Task")
        elsif action_name == "edit"
          add_breadcrumb("Edit #{@task.title}")
        else
          add_breadcrumb(@task.title)
        end
      end
    end
end
