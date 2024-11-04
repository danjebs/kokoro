require "test_helper"

class Comments::EditTest < ViewComponent::TestCase
  def setup
    @comment = comments(:task_to_do_1_comment_1)
  end

  test "renders the edit comment form with content" do
    render_inline(Comments::Edit.new(comment: @comment))

    assert_selector "form"
    assert_selector "textarea", text: @comment.content
  end
end