require "test_helper"

class Boards::Tasks::NewTest < ViewComponent::TestCase
  def setup
    @board = boards(:one)
    @task = Task.new(board: @board)
  end

  test "renders the new task form" do
    render_inline(Boards::Tasks::New.new(task: @task))

    assert_text "Create a New Task"
    assert_selector "form"
  end
end