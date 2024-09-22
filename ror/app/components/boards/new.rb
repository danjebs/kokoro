module Boards
  class New < ViewComponent::Base
    def initialize(board:)
      @board = board
    end

    private

    attr_reader :board
  end
end