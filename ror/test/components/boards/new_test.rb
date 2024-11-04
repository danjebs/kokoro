require "test_helper"

class Boards::NewTest < ViewComponent::TestCase
  def setup
    @board = Board.new
  end

  test "renders the new board form" do
    render_inline(Boards::New.new(board: @board))

    assert_text "Create a New Board"
    assert_selector "form"
  end
end