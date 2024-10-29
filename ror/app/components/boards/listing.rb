module Boards
  class Listing < BaseComponent
    with_collection_parameter :board

    def initialize(board:)
      @board = board
    end

    private

    attr_reader :board
  end
end