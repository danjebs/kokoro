require "test_helper"

class Boards::Tasks::ShowTest < ViewComponent::TestCase
  def setup
    @user = users(:bean)
    @task = tasks(:task_to_do_1)
  end

  # TODO: implement component without current_user helper
  # test "renders the show task component with task details" do
  #   render_inline(Boards::Tasks::Show.new(task: @task))

  #   assert_text @task.name
  #   assert_selector "div", text: @task.name
  # end
end