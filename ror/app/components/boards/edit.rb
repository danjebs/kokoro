class Boards::Edit < BaseComponent
  def initialize(board:)
    @board = board
  end

  private

  attr_accessor :board
end
