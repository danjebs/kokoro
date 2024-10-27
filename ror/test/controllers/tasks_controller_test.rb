require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @board_bean = boards(:one)
    @board_bundy = boards(:two)

    @status_to_do = task_statuses(:to_do)
    @status_doing = task_statuses(:doing)
    @status_done = task_statuses(:done)

    @task_to_do_1 = tasks(:task_to_do_1)
    @task_to_do_2 = tasks(:task_to_do_2)
    @task_to_do_3 = tasks(:task_to_do_3)
    @task_doing_1 = tasks(:task_doing_1)
    @task_doing_2 = tasks(:task_doing_2)
    @task_done_1 = tasks(:task_done_1)
    @task_done_2 = tasks(:task_done_2)

    @task_no_access = tasks(:task_no_access)

    @user = users(:bean)

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
    get new_task_url, params: { task: { board_id: @board_bean.id } }

    assert_response :success
  end

  test "should create task with valid attributes" do
    assert_difference("Task.count") do
      post tasks_url, params: {
        task: {
          title: "New Task",
          board_id: @board_bean.id,
          task_status_id: @status_to_do.id,
          creator_id: @user.id,
          assignee_id: @user.id
        }
      }
    end

    assert_redirected_to Task.last
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
    assert_redirected_to @task_to_do_1
    assert_equal "Task was successfully updated.", flash[:notice]
  end

  test "should destroy task" do
    board = @task_to_do_1.board

    assert_difference("Task.count", -1) do
      delete task_url(@task_to_do_1)
    end

    assert_redirected_to board_url @board_bean
  end

  # Authorization tests
  test "should not get index if not authorized" do
    sign_out @user
    get tasks_url
    assert_redirected_to new_user_session_url
  end

  test "should not get new if not authorized" do
    sign_out @user
    get new_task_url, params: { task: { board_id: @board_bean.id } }
    assert_redirected_to new_user_session_url
  end

  test "should not create task if not authorized" do
    sign_out @user
    assert_no_difference("Task.count") do
      post tasks_url, params: {
        task: {
          title: "New Task",
          board_id: @board_bean.id,
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
        board_id: @board_bean.id,
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

  test "should get show if user has access to board" do
    get board_url(@board_bean)
    assert_response :success
  end

  test "should not get show if user does not have access to board" do
    get board_url(@board_bundy)
    assert_response :forbidden
  end

  test "should create task if user has access to board" do
    assert_difference("Task.count") do
      post tasks_url, params: {
        task: {
          title: "New Task",
          board_id: @board_bean.id,
          task_status_id: task_statuses(:to_do).id,
          assignee_id: @user.id
        }
      }
    end
    assert_redirected_to @board_bean.tasks.last
  end

  test "should not create task if user does not have access to board" do
    assert_no_difference("Task.count") do
      post tasks_url, params: {
        task: {
          title: 'New Task',
          board_id: @board_bundy.id,
          task_status_id: task_statuses(:to_do).id,
          assignee_id: @user.id
        }
      }
    end
    assert_response :forbidden
  end

  test "should update task if user has access to board" do
    patch task_url(@task_to_do_1), params: { task: { title: 'Updated Task' } }
    assert_redirected_to @task_to_do_1
  end

  test "should not update task if user does not have access to board" do
    patch task_url(@task_no_access), params: { task: { title: 'Updated Task' } }
    assert_response :forbidden
  end

  test "should destroy task if user has access to board" do
    assert_difference("Task.count", -1) do
      delete task_url(@task_done_1)
    end
    assert_redirected_to board_url(@board_bean)
  end

  test "should not destroy task if user does not have access to board" do
    assert_no_difference("Task.count") do
      delete task_url(@task_no_access)
    end
    assert_response :forbidden
  end

  test "should only show tasks accessible by current user" do
    get board_url(@board_bean)

    assert_response :success
    assert_select "*", { text: @task_to_do_1.title, count: 1 }
    assert_select "*", { text: @task_no_access.title, count: 0 }
  end
end
