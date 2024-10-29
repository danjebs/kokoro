class Boards::List < BaseComponent
  def initialize(boards:, pagy:)
    @boards = boards
    @pagy = pagy
  end

  private

  attr_reader :boards, :pagy
end
