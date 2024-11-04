require "test_helper"
include Pagy::Backend

class Boards::ListTest < ViewComponent::TestCase
  def setup
    @boards = Board.all
    @pagy, @boards = pagy(@boards, page: 1)
  end

  test "renders the list component with pagination" do
    render_inline(Boards::List.new(boards: @boards, pagy: @pagy))

    assert_text "My Boards"
    assert_selector "ul"
    assert_selector "li", count: @boards.size
  end
end