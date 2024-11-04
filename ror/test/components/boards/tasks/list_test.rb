require "test_helper"
include Pagy::Backend

class Boards::Tasks::ListTest < ViewComponent::TestCase
  def setup
    @tasks = Task.all
    @pagy, @tasks = pagy(@tasks, page: 1)
  end

  test "renders the task list component with pagination" do
    render_inline(Boards::Tasks::List.new(tasks: @tasks, pagy: @pagy))

    @tasks.each do |task|
      assert_selector "div##{dom_id(task, :listing)}"
    end
  end
end