require "test_helper"

class Boards::Tasks::EditTest < ViewComponent::TestCase
  def setup
    @task = tasks(:task_to_do_1)
  end

  test "renders the edit task component" do
    render_inline(Boards::Tasks::Edit.new(task: @task))

    assert_text @task.name
  end
end