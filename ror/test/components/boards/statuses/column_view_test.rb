require "test_helper"

class Boards::Statuses::ColumnViewTest < ViewComponent::TestCase
  def setup
    @task_status = task_statuses(:to_do)
    @tasks = @task_status.tasks
  end

  test "renders the column view component with tasks" do
    render_inline(Boards::Statuses::ColumnView.new(task_status: @task_status))

    assert_text @task_status.name
    @tasks.each do |task|
      assert_selector "a#listing_task_#{task.id}"
    end
  end
end