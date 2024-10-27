require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task_owner = users(:bean)
    @task_viewer = users(:bundy)
    @task_no_access_user = users(:boogi)
    @task = tasks(:task_to_do_1)
    @comment = comments(:task_to_do_1_comment_1)
  end

  test "should create comment if user has access" do
    sign_in @task_viewer

    assert_difference("Comment.count", 1) do
      post(
        comments_url(@task, format: :html),
        params: { comment: { content: "New comment", commentable_type: "Task", commentable_id: @task.id } }
      )
    end

    assert_redirected_to @task
  end

  test "should not create comment if user does not have access" do
    sign_in @task_no_access_user

    assert_no_difference("Comment.count") do
      post(
        comments_url(@task, format: :html),
        params: { comment: { content: "New comment", commentable_type: "Task", commentable_id: @task.id } }
      )
    end

    assert_response :forbidden
  end

  test "should update comment if user is the creator" do
    sign_in @task_owner

    patch(
      comment_url(@comment, format: :html),
      params: { comment: { content: "Updated content" } }
    )

    assert_redirected_to @comment.commentable
    @comment.reload
    assert_equal "Updated content", @comment.content
  end

  test "should not update comment if user is not the creator" do
    sign_in @task_viewer

    patch(
      comment_url(@comment, format: :html),
      params: { comment: { content: "Updated content" } }
    )

    assert_response :forbidden
  end

  test "should destroy comment if user is the creator" do
    sign_in @task_owner

    assert_difference("Comment.count", -1) do
      delete comment_url(@comment, format: :html)
    end
    assert_redirected_to @comment.commentable
  end

  test "should not destroy comment if user is not the creator" do
    sign_in @task_viewer

    assert_no_difference("Comment.count") do
      delete comment_url(@comment, format: :html)
    end

    assert_response :forbidden
  end
end
