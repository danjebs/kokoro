require "test_helper"

class TaskStatusesControllerTest < ActionDispatch::IntegrationTest
  # setup do
  #   @task_status = task_statuses(:one)
  #   @user = users(:bean)

  #   sign_in @user
  # end

  # test "should get index" do
  #   get task_statuses_url
  #   assert_response :success
  #   assert_not_nil assigns(:task_statuses)
  # end

  # test "should get new" do
  #   get new_task_status_url
  #   assert_response :success
  # end

  # test "should create task status with valid attributes" do
  #   assert_difference("TaskStatus.count") do
  #     post task_statuses_url, params: { task_status: { name: "New Status", board_id: @task_status.board_id } }
  #   end

  #   assert_redirected_to task_status_url(TaskStatus.last)
  #   assert_equal "Task status was successfully created.", flash[:notice]
  # end

  # test "should show task status" do
  #   get task_status_url(@task_status)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_task_status_url(@task_status)
  #   assert_response :success
  # end

  # test "should update task status" do
  #   patch task_status_url(@task_status), params: { task_status: { name: "Updated Status" } }
  #   assert_redirected_to task_status_url(@task_status)
  #   assert_equal "Task status was successfully updated.", flash[:notice]
  # end

  # test "should destroy task status" do
  #   assert_difference("TaskStatus.count", -1) do
  #     delete task_status_url(@task_status)
  #   end

  #   assert_redirected_to task_statuses_url
  #   assert_equal "Task status was successfully destroyed.", flash[:notice]
  # end

  # # Authorization tests
  # test "should not get index if not authorized" do
  #   sign_out @user
  #   get task_statuses_url
  #   assert_redirected_to new_user_session_url
  # end

  # test "should not get new if not authorized" do
  #   sign_out @user
  #   get new_task_status_url
  #   assert_redirected_to new_user_session_url
  # end

  # test "should not create task status if not authorized" do
  #   sign_out @user
  #   assert_no_difference("TaskStatus.count") do
  #     post task_statuses_url, params: { task_status: { name: "New Status", board_id: @task_status.board_id } }
  #   end

  #   assert_redirected_to new_user_session_url
  # end

  # test "should not show task status if not authorized" do
  #   sign_out @user
  #   get task_status_url(@task_status)
  #   assert_redirected_to new_user_session_url
  # end

  # test "should not get edit if not authorized" do
  #   sign_out @user
  #   get edit_task_status_url(@task_status)
  #   assert_redirected_to new_user_session_url
  # end

  # test "should not update task status if not authorized" do
  #   sign_out @user
  #   patch task_status_url(@task_status), params: { task_status: { name: "Updated Status" } }
  #   assert_redirected_to new_user_session_url
  # end

  # test "should not destroy task status if not authorized" do
  #   sign_out @user
  #   assert_no_difference("TaskStatus.count") do
  #     delete task_status_url(@task_status)
  #   end

  #   assert_redirected_to new_user_session_url
  # end
end
