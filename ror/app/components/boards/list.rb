module Boards
  class List < BaseComponent
    def initialize(boards:)
      @boards = boards
    end

    private

    attr_reader :boards
  end
end