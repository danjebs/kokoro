require "test_helper"

class InvitationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pending = invitations(:status_pending)
    @accepted = invitations(:status_accepted)
    @declined = invitations(:status_declined)

    @board_owner = users(:bean)
    @board_collaborator = users(:bundy)
    @board_non_collaborator = users(:boogi)
  end

  test "should allow viewing if status is pending" do
    sign_in @pending.invitee
    get invitation_url(@pending)
    assert_response :success
  end

  test "should not allow viewing if status is accepted" do
    sign_in @accepted.invitee
    get invitation_url(@accepted)
    assert_response :forbidden
  end

  test "should not allow viewing if status is declined" do
    sign_in @declined.invitee
    get invitation_url(@declined)
    assert_response :forbidden
  end

  test "should allow accepting if status is pending" do
    sign_in @pending.invitee
    patch invitation_url(@pending), params: { invitation: { status: :accepted } }
    assert_redirected_to @pending.collaborateable
  end

  test "should allow declining if status is pending" do
    sign_in @pending.invitee
    patch invitation_url(@pending), params: { invitation: { status: :declined } }
    assert_redirected_to invitations_url
  end

  test "should not allow editing if status is accepted" do
    sign_in @accepted.invitee
    patch invitation_url(@accepted), params: { invitation: { status: :declined } }
    assert_response :forbidden
  end

  test "should not allow editing if status is declined" do
    sign_in @declined.invitee
    patch invitation_url(@declined), params: { invitation: { status: :pending } }
    assert_response :forbidden
  end

  test "should allow invitee to view invitation" do
    sign_in @pending.invitee
    get invitation_url(@pending)
    assert_response :success
  end

  test "should allow inviter to view invitation" do
    sign_in @pending.inviter
    get invitation_url(@pending)
    assert_response :success
  end

  test "should not allow non-collaborator to view invitation" do
    sign_in @board_non_collaborator
    get invitation_url(@pending)
    assert_response :forbidden
  end

  test "should not allow other collaborator to view invitation" do
    sign_in @board_collaborator
    get invitation_url(@pending)
    assert_response :forbidden
  end

  test "should show invitations" do
    sign_in users(:bean)

    get invitations_url
    assert_response :success
    assert_select "li[id^=listing_invitation_]", count: 1

    get invitation_url(invitations(:bundy_invites_bean_to_board_two))
    assert_response :success
    assert_select "li[id^=listing_invitation_]", count: 1
  end

  test "should not show accepted invitations" do
    sign_in users(:bundy)

    get invitations_url
    assert_response :success
    assert_select "li[id^=listing_invitation_]", count: 0

    get invitation_url(invitations(:status_accepted))
    assert_response :forbidden
  end
end
