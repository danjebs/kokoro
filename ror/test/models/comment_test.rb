require "test_helper"

class CommentTest < ActiveSupport::TestCase
  setup do
    @bean = users(:bean)
    @task = tasks(:task_to_do_1)
    @comment = comments(:task_to_do_1_comment_1)
  end

  test "should allow viewing comments if user has access to the task" do
    assert @comment.accessible_by?(@bean)
  end

  test "should not allow viewing comments if user does not have access to the task" do
    inacessible_comment = comments(:task_no_access_comment_1)
    refute inacessible_comment.accessible_by?(@bean)
  end

  test "should validate presence of content" do
    @comment.content = nil
    refute @comment.valid?
    assert_includes @comment.errors[:content], "can't be blank"
  end

  test "should validate presence of user" do
    @comment.user = nil
    refute @comment.valid?
    assert_includes @comment.errors[:user], "must exist"
  end

  test "should validate presence of commentable" do
    @comment.commentable = nil
    refute @comment.valid?
    assert_includes @comment.errors[:commentable], "must exist"
  end

  test "should validate user has access to commentable" do
    @comment.user = users(:boogi)
    refute @comment.valid?
    assert_includes @comment.errors[:user], "does not have access to the Task"
  end

  test "should not allow user_id to change once set" do
    @comment.user = @bean
    @comment.save!
    @comment.user = users(:bundy)
    refute @comment.valid?
    assert_includes @comment.errors[:user_id], "cannot be changed once set"
  end

  test "should belong to a user" do
    assert_equal @bean, @comment.user
  end

  test "should belong to a commentable" do
    assert_equal @task, @comment.commentable
  end
end
