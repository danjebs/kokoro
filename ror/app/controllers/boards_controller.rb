class BoardsController < ApplicationController
  layout 'dashboard'

  before_action :set_board, only: %i[show edit update destroy]
  before_action :authorize_board, only: %i[show edit update destroy]

  def index
    authorize Board

    @boards = Board.all

    render Boards::List.new(boards: @boards)
  end

  def show
    authorize @board

    render Boards::Show.new(board: @board)
  end

  def new
    authorize Board

    @board = Board.new

    render Boards::New.new(board: @board)
  end

  def edit
    authorize @board

    render Boards::New.new(board: @board)
  end

  def create
    authorize Board

    @board = Board.new(**board_params, creator: current_user)

    respond_to do |format|
      if @board.save
        format.html { redirect_to @board, notice: "Board was successfully created." }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render Boards::New.new(board: @board), status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @board

    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to @board, notice: "Board was successfully updated." }
        format.json { render :show, status: :ok, location: @board }
      else
        format.html { render Boards::New.new(board: @board), status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @board

    @board.destroy!

    respond_to do |format|
      format.html { redirect_to boards_path, status: :see_other, notice: "Board was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def authorize_board
    authorize @board
  end

  def board_params
    params.require(:board).permit(:name)
  end
end
