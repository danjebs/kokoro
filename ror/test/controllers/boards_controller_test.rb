require "test_helper"

class BoardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @board = boards(:one)
    @user = users(:bean)

    sign_in @user
  end

  test "should get index" do
    get boards_url
    assert_response :success
    assert_includes @response.body, @board.name
  end

  test "should get new" do
    get new_board_url
    assert_response :success
  end

  test "should create board with valid attributes" do
    assert_difference('Board.count') do
      post boards_url, params: { board: { name: 'New Board' } }
    end

    assert_redirected_to board_url(Board.last)
    assert_equal 'Board was successfully created.', flash[:notice]
  end

  test "should show board" do
    get board_url(@board)
    assert_response :success
  end

  test "should get edit" do
    get edit_board_url(@board)
    assert_response :success
  end

  test "should update board" do
    patch board_url(@board), params: { board: { name: 'Updated Board' } }
    assert_redirected_to board_url(@board)
    assert_equal 'Board was successfully updated.', flash[:notice]
  end

  test "should not destroy board" do
    assert_no_difference('Board.count') do
      delete board_url(@board)
    end

    assert_redirected_to root_path
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
    assert_no_difference('Board.count') do
      post boards_url, params: { board: { name: 'New Board' } }
    end

    assert_redirected_to new_user_session_url
  end

  test "should not show board if not authorized" do
    sign_out @user
    get board_url(@board)
    assert_redirected_to new_user_session_url
  end

  test "should not get edit if not authorized" do
    sign_out @user
    get edit_board_url(@board)
    assert_redirected_to new_user_session_url
  end

  test "should not update board if not authorized" do
    sign_out @user
    patch board_url(@board), params: { board: { name: 'Updated Board' } }
    assert_redirected_to new_user_session_url
  end

  test "should not destroy board if not authorized" do
    sign_out @user
    assert_no_difference('Board.count') do
      delete board_url(@board)
    end

    assert_redirected_to new_user_session_url
  end

  # Additional tests
  test "should set default status to active" do
    post boards_url, params: { board: { name: 'New Board' } }
    assert_equal 'active', Board.last.status
  end

  test "should not create board with duplicate name for the same creator" do
    assert_no_difference("Board.count") do
      post boards_url, params: { board: { name: @board.name } }
    end
    assert_response :unprocessable_entity
  end

  test "should not create board without a name" do
    assert_no_difference('Board.count') do
      post boards_url, params: { board: { name: '' } }
    end

    assert_response :unprocessable_entity
  end
end
