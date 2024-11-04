require "test_helper"

class Boards::EditTest < ViewComponent::TestCase
  def setup
    @board = boards(:one)
  end

  test "renders the edit component" do
    render_inline(Boards::Edit.new(board: @board))

    # Adjust the assertion to check for any existing content or placeholder
    assert_text "TBC" # Assuming "TBC" is the placeholder content
  end
end