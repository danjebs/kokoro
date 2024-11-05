class Boards::Show < BaseComponent
  def initialize(board:)
    @board = board
  end

  private

  attr_reader :board
end
