module Boards
  class List < BaseComponent
    def initialize(boards:, pagy:)
      @boards = boards
      @pagy = pagy
    end

    private

    attr_reader :boards, :pagy
  end
end