require "test_helper"

class BoardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @board_bean = boards(:one)
    @board_bundy = boards(:two)
    @user = users(:bean)
    @other_user = users(:bundy)
    sign_in @user
  end

  test "should get index" do
    get boards_url
    assert_response :success
    assert_includes @response.body, @board_bean.name
  end

  test "should get new" do
    get new_board_url
    assert_response :success
  end

  test "should create board with valid attributes" do
    assert_difference("Board.count") do
      post boards_url, params: {
        board: {
          name: "New Board"
        }
      }
    end

    assert_redirected_to board_url(Board.last)
    assert_equal "Board was successfully created.", flash[:notice]
  end

  test "should show board" do
    get board_url(@board_bean)
    assert_response :success
  end

  test "should get edit" do
    get edit_board_url(@board_bean)
    assert_response :success
  end

  test "should update board" do
    patch board_url(@board_bean), params: { board: { name: "Updated Board" } }
    assert_redirected_to board_url(@board_bean)
    assert_equal "Board was successfully updated.", flash[:notice]
  end

  test "should not destroy board" do
    assert_no_difference("Board.count") do
      delete board_url(@board_bean)
    end

    assert_response :forbidden
  end

  # Authorization tests
  test "should not get index if not authorized" do
    sign_out @user
    get boards_url
    assert_redirected_to new_user_session_url
  end

  test "should not get new if not authorized" do
    sign_out @user
    get new_board_url
    assert_redirected_to new_user_session_url
  end

  test "should not create board if not authorized" do
    sign_out @user
    assert_no_difference("Board.count") do
      post boards_url, params: { board: { name: "New Board" } }
    end

    assert_redirected_to new_user_session_url
  end

  test "should not show board if not authorized" do
    sign_out @user
    get board_url(@board_bean)
    assert_redirected_to new_user_session_url
  end

  test "should not get edit if not authorized" do
    sign_out @user
    get edit_board_url(@board_bean)
    assert_redirected_to new_user_session_url
  end

  test "should not update board if not authorized" do
    sign_out @user
    patch board_url(@board_bean), params: { board: { name: "Updated Board" } }
    assert_redirected_to new_user_session_url
  end

  test "should not destroy board if not authorized" do
    sign_out @user
    assert_no_difference("Board.count") do
      delete board_url(@board_bean)
    end

    assert_redirected_to new_user_session_url
  end

  test "should get edit if user is a board user" do
    @board_bean.add_collaborator(@user)
    get edit_board_url(@board_bean)
    assert_response :success
  end

  test "should not get edit if user is not a board user" do
    sign_out @user
    sign_in @other_user
    get edit_board_url(@board_bean)
    assert_response :forbidden
  end

  test "should update board if user is a board user" do
    @board_bean.add_collaborator(@user)
    patch board_url(@board_bean), params: { board: { name: 'Updated Board' } }
    assert_redirected_to @board_bean
  end

  test "should not update board if user is not a board user" do
    sign_out @user
    sign_in @other_user
    patch board_url(@board_bean), params: { board: { name: 'Updated Board' } }
    # assert_redirected_to root_url
    assert_response :forbidden
  end

  test "should only show boards accessible by current user" do
    get boards_url

    assert_response :success
    assert_select "*", text: @board_bean.name
    assert_select "*", text: @board_bundy.name, count: 0
  end
end
