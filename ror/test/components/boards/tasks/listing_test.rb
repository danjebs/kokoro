require "test_helper"

class Boards::Tasks::ListingTest < ViewComponent::TestCase
  def setup
    @task = tasks(:task_to_do_1)
  end

  test "renders the task listing component with task details" do
    render_inline(Boards::Tasks::Listing.new(task: @task))

    assert_text @task.name
    assert_text @task.assignee_name
  end
end