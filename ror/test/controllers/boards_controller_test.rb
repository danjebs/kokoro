require "test_helper"

class BoardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @board = boards(:board_one)
    @creator = users(:user_admin)
  end

  test "should get index" do
    get boards_url
    assert_response :success
  end

  test "should get new" do
    get new_board_url
    assert_response :success
  end

  test "should create board" do
    assert_difference("Board.count") do
      post boards_url, params: { board: { name: "Board three" } }
    end

    assert_redirected_to board_url(Board.last)
  end

  test "should create board with valid attributes" do
    assert_difference("Board.count") do
      post boards_url, params: { board: { name: "Board three", creator_id: @creator.id } }
    end
    assert_redirected_to board_url(Board.last)
  end

  test "should not create board without a name" do
    assert_no_difference("Board.count") do
      post boards_url, params: { board: { name: nil, creator_id: @creator.id } }
    end
    assert_response :unprocessable_entity
  end

  test "should not create board with duplicate name for the same creator" do
    Board.create!(name: "Unique Board", creator: @creator)
    assert_no_difference("Board.count") do
      post boards_url, params: { board: { name: "Unique Board", creator_id: @creator.id } }
    end
    assert_response :unprocessable_entity
  end

  test "should set default status to active" do
    post boards_url, params: { board: { name: "New Board", creator_id: @creator.id } }
    board = Board.last
    assert_equal "active", board.status
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
    patch board_url(@board), params: { board: { name: "Board one new name" } }
    assert_redirected_to board_url(@board)
  end

  test "should destroy board" do
    assert_difference("Board.count", -1) do
      delete board_url(@board)
    end

    assert_redirected_to boards_url
  end
end
