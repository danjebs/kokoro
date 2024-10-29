class BoardsController < DashboardController
  before_action :set_breadcrumbs, only: %i[index show edit]
  before_action :set_board, only: %i[show edit update destroy]
  before_action :initialize_board, only: %i[new create]

  def index
    @pagy, @boards = pagy(policy_scope(Board.all), limit: 20)

    authorize @boards
  end

  def show
    @tasks_by_status = @board.task_statuses.ordered.map do |task_status|
      [task_status, task_status.tasks.ordered.accessible_by(current_user)]
    end

    add_breadcrumb(@board.name)
  end

  def new
    add_breadcrumb("New Board")
  end

  def edit
    add_breadcrumb("Edit #{@board.name}")
  end

  def create
    if @board.save
      redirect_to @board, notice: "Board was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @board.update(board_params)
      redirect_to @board, notice: "Board was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @board.destroy!

    redirect_to boards_path, status: :see_other, notice: "Board was successfully destroyed."
  end

  private

  def set_board
    @board = Board.find(params[:id])

    authorize @board
  end

  def initialize_board
    @board = Board.new(creator: current_user, **board_params)

    authorize @board
  end

  def board_params
    return {} unless params[:board].present?

    params.require(:board).permit(:name)
  end

  def set_breadcrumbs
    add_breadcrumb("Boards", action_name == "index" ? nil : boards_path)
  end
end
