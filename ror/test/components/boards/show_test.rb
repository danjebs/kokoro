require "test_helper"

class Boards::ShowTest < ViewComponent::TestCase
  def setup
    @board = boards(:one)
    @tasks_by_status = @board.task_statuses.ordered.map do |task_status|
      [task_status, task_status.tasks.ordered]
    end
  end

  test "renders the show component with board and tasks" do
    render_inline(Boards::Show.new(board: @board, tasks_by_status: @tasks_by_status))

    assert_text @board.name
    assert_selector "h1", text: @board.name

    @tasks_by_status.each do |task_status, tasks|
      assert_selector "div##{dom_id(task_status, :column)}" do
        tasks.each do |task|
          assert_selector "a##{dom_id(task, :listing)}"
        end
      end
    end
  end
end
