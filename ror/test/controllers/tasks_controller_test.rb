require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task_to_do_1 = tasks(:task_to_do_1)
    @task_to_do_2 = tasks(:task_to_do_2)
    @task_to_do_3 = tasks(:task_to_do_3)
    @task_doing_1 = tasks(:task_doing_1)
    @task_doing_2 = tasks(:task_doing_2)
    @task_done_1 = tasks(:task_done_1)
    @task_done_2 = tasks(:task_done_2)
    @user = users(:bean)
    @board = boards(:one)

    @status_to_do = task_statuses(:to_do)
    @status_doing = task_statuses(:doing)
    @status_done = task_statuses(:done)

    sign_in @user
  end

  test "should get index" do
    get tasks_url
    assert_response :success
  end

  test "should not get new without board set" do
    get new_task_url

    assert_redirected_to tasks_url
  end

  test "should get new with board set" do
    get new_task_url, params: { task: { board_id: @board.id } }

    assert_response :success
  end

  test "should create task with valid attributes" do
    assert_difference("Task.count") do
      post tasks_url, params: {
        task: {
          title: "New Task",
          board_id: @board.id,
          task_status_id: @status_to_do.id,
          creator_id: @user.id,
          assignee_id: @user.id
        }
      }
    end

    assert_redirected_to board_url(Task.last.board)
    assert_equal "Task was successfully created.", flash[:notice]
  end

  test "should show task" do
    get task_url(@task_to_do_1)
    assert_response :success
  end

  test "should get edit" do
    get edit_task_url(@task_to_do_1)
    assert_response :success
  end

  test "should update task" do
    patch task_url(@task_to_do_1), params: {
      task: {
        title: "Updated Task",
        task_status_id: @status_done.id,
        creator_id: @user.id,
        assignee_id: @user.id
      }
    }
    assert_redirected_to board_url(@task_to_do_1.board)
    assert_equal "Task was successfully updated.", flash[:notice]
  end

  test "should destroy task" do
    board = @task_to_do_1.board

    assert_difference("Task.count", -1) do
      delete task_url(@task_to_do_1)
    end

    assert_redirected_to board_url @board
  end

  # Authorization tests
  test "should not get index if not authorized" do
    sign_out @user
    get tasks_url
    assert_redirected_to new_user_session_url
  end

  test "should not get new if not authorized" do
    sign_out @user
    get new_task_url, params: { task: { board_id: @board.id } }
    assert_redirected_to new_user_session_url
  end

  test "should not create task if not authorized" do
    sign_out @user
    assert_no_difference("Task.count") do
      post tasks_url, params: {
        task: {
          title: "New Task",
          board_id: @board.id,
          task_status_id: @status_doing.id,
          creator_id: @user.id,
          assignee_id: @user.id
        }
      }
    end

    assert_redirected_to new_user_session_url
  end

  test "should not show task if not authorized" do
    sign_out @user
    get task_url(@task_to_do_1)
    assert_redirected_to new_user_session_url
  end

  test "should not get edit if not authorized" do
    sign_out @user
    get edit_task_url(@task_to_do_1)
    assert_redirected_to new_user_session_url
  end

  test "should not update task if not authorized" do
    sign_out @user
    patch task_url(@task_to_do_1), params: {
      task: {
        title: "Updated Task",
        board_id: @board.id,
        task_status_id: @status_done.id,
        creator_id: @user.id,
        assignee_id: @user.id
      }
    }
    assert_redirected_to new_user_session_url
  end

  test "should not destroy task if not authorized" do
    sign_out @user
    assert_no_difference("Task.count") do
      delete task_url(@task_to_do_1)
    end

    assert_redirected_to new_user_session_url
  end

  # Test moving task between columns
  test "should move task to another column" do
    patch task_url(@task_to_do_1), params: {
      task: {
        task_status_id: @status_doing.id
      }
    }
    assert_redirected_to board_url(@task_to_do_1.board)
    @task_to_do_1.reload
    assert_equal @status_doing.id, @task_to_do_1.task_status_id
    assert_equal "Task was successfully updated.", flash[:notice]
  end

  # Test moving task within the same column
  test "should move task within the same column" do
    patch task_url(@task_to_do_1), params: {
      task: {
        position: 2
      }
    }
    assert_redirected_to board_url(@task_to_do_1.board)
    @task_to_do_1.reload
    assert_equal 2, @task_to_do_1.position
    assert_equal "Task was successfully updated.", flash[:notice]

    # Ensure positions of other tasks are updated
    @task_to_do_2.reload
    assert_equal 1, @task_to_do_2.position
    @task_to_do_3.reload
    assert_equal 3, @task_to_do_3.position
  end

  # Test moving task between columns and into a specific spot
  test "should move task to another column and specific position" do
    patch task_url(@task_to_do_1), params: {
      task: {
        task_status_id: @status_doing.id,
        position: 2
      }
    }
    assert_redirected_to board_url(@task_to_do_1.board)
    @task_to_do_1.reload
    assert_equal @status_doing.id, @task_to_do_1.task_status_id
    assert_equal 2, @task_to_do_1.position
    assert_equal "Task was successfully updated.", flash[:notice]

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