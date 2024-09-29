module Boards
  class Edit < ViewComponent::Base
    def initialize(board:)
      @board = board
    end
  end
end
