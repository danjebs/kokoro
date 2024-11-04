require "test_helper"

class Boards::ListingTest < ViewComponent::TestCase
  def setup
    @board = boards(:one)
  end

  test "renders the listing component with board name" do
    render_inline(Boards::Listing.new(board: @board))

    assert_selector "li", text: @board.name
  end
end