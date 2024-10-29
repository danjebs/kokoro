module Boards
  class Show < BaseComponent
    def initialize(board:, tasks_by_status:)
      @board = board
      @tasks_by_status = tasks_by_status
    end

    private

    attr_reader :board, :tasks_by_status
  end
end