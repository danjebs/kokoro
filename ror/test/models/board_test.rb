require "test_helper"

class BoardTest < ActiveSupport::TestCase
  setup do
    @user = users(:bean)
    @board = boards(:one)
  end

  test "should set default status to active" do
    board = Board.create(name: "New Board", creator: @user)
    assert_equal "active", board.status
  end

  test "should not create board with duplicate name for the same creator" do
    duplicate_board = Board.new(name: @board.name, creator: @board.creator)
    assert_not duplicate_board.save
  end

  test "should not create board without a name" do
    board = Board.new(name: "", creator: @user)
    assert_not board.save
  end
end
