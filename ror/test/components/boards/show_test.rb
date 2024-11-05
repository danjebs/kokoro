require "test_helper"

class Boards::ShowTest < ViewComponent::TestCase
  def setup
    @board = boards(:one)
  end

  test "renders the show component with board and tasks" do
    render_inline(Boards::Show.new(board: @board))

    assert_text @board.name
    assert_selector "h1", text: @board.name

    @board.task_statuses.each do |task_status|
      assert_selector "div##{dom_id(task_status, :column)}" do
        task_status.tasks.each do |task|
          assert_selector "a##{dom_id(task, :listing)}"
        end
      end
    end
  end
end
