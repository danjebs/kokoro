require "test_helper"

class TaskTest < ActiveSupport::TestCase
  setup do
    @board_bean = boards(:one)
    @status_to_do = task_statuses(:to_do)
    @status_doing = task_statuses(:doing)
    @task_to_do_1 = tasks(:task_to_do_1)
    @task_to_do_2 = tasks(:task_to_do_2)
    @task_to_do_3 = tasks(:task_to_do_3)
    @task_doing_1 = tasks(:task_doing_1)
    @task_doing_2 = tasks(:task_doing_2)
  end

  test "should move task to another column" do
    @task_to_do_1.update(task_status_id: @status_doing.id)
    @task_to_do_1.reload
    assert_equal @status_doing.id, @task_to_do_1.task_status_id
  end

  test "should move task within the same column" do
    @task_to_do_1.update(position: 2)
    @task_to_do_1.reload
    assert_equal 2, @task_to_do_1.position

    # Ensure positions of other tasks are updated
    @task_to_do_2.reload
    assert_equal 1, @task_to_do_2.position
    @task_to_do_3.reload
    assert_equal 3, @task_to_do_3.position
  end

  test "should move task to another column and specific position" do
    @task_to_do_1.update(task_status_id: @status_doing.id, position: 2)
    @task_to_do_1.reload
    assert_equal @status_doing.id, @task_to_do_1.task_status_id
    assert_equal 2, @task_to_do_1.position

    # Ensure positions of other tasks in origin column are updated
    @task_to_do_2.reload
    assert_equal 1, @task_to_do_2.position
    @task_to_do_3.reload
    assert_equal 2, @task_to_do_3.position

    # Ensure positions of other tasks in target column are updated
    @task_doing_1.reload
    assert_equal 1, @task_doing_1.position
    @task_doing_2.reload
    assert_equal 3, @task_doing_2.position
  end
end
