module Boards
  class Listing < ViewComponent::Base
    with_collection_parameter :board

    def initialize(board:)
      @board = board
    end

    private

    attr_reader :board
  end
end