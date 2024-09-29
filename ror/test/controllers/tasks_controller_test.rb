require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:task_to_do)
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
          task_status_id: @status_to_do.id
        }
      }
    end

    assert_redirected_to board_url(Task.last.board)
    assert_equal "Task was successfully created.", flash[:notice]
  end

  test "should show task" do
    get task_url(@task)
    assert_response :success
  end

  test "should get edit" do
    get edit_task_url(@task)
    assert_response :success
  end

  test "should update task" do
    patch task_url(@task), params: {
      task: {
        title: "Updated Task",
        task_status_id: @status_done.id
      }
    }
    assert_redirected_to task_url(@task)
    assert_equal "Task was successfully updated.", flash[:notice]
  end

  test "should destroy task" do
    assert_difference("Task.count", -1) do
      delete task_url(@task)
    end

    assert_redirected_to tasks_url
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
          task_status_id: @status_doing.id
        }
      }
    end

    assert_redirected_to new_user_session_url
  end

  test "should not show task if not authorized" do
    sign_out @user
    get task_url(@task)
    assert_redirected_to new_user_session_url
  end

  test "should not get edit if not authorized" do
    sign_out @user
    get edit_task_url(@task)
    assert_redirected_to new_user_session_url
  end

  test "should not update task if not authorized" do
    sign_out @user
    patch task_url(@task), params: {
      task: {
        title: "Updated Task",
        board_id: @board.id,
        task_status_id: @status_done.id
        }
      }
    assert_redirected_to new_user_session_url
  end

  test "should not destroy task if not authorized" do
    sign_out @user
    assert_no_difference("Task.count") do
      delete task_url(@task)
    end

    assert_redirected_to new_user_session_url
  end
end
