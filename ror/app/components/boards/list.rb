module Boards
  class List < ViewComponent::Base
    def initialize(boards:)
      @boards = boards
    end

    private

    attr_reader :boards
  end
end