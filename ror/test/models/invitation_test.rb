require "test_helper"

class InvitationTest < ActiveSupport::TestCase
  setup do
    @board = boards(:one)

    @owner = users(:bean)
    @collaborator = users(:bundy)

    @non_collaborator = users(:boogi)
  end

  test "should allow creation by an owner of the board" do
    invitation = Invitation.create(inviter: @collaborator, email: @non_collaborator.email, collaborateable: @board)
    assert_not invitation.valid?
  end

  test "should not allow creation by an existing collaborator of the board" do
    invitation = Invitation.create(inviter: @collaborator, email: @non_collaborator.email, collaborateable: @board)
    assert_not invitation.valid?
  end

  test "should not allow creation by a non-collaborator" do
    invitation = Invitation.create(inviter: @non_collaborator, invitee: @collaborator, collaborateable: @board)
    assert_not invitation.valid?
  end

  test "should not allow invitation to existing collaborator" do
    @board.add_collaborator(@collaborator)
    invitation = Invitation.create(inviter: @owner, invitee: @collaborator, collaborateable: @board)
    assert_not invitation.valid?
  end

  test "should not allow duplicate invitation if status is pending or accepted" do
    Invitation.create(email: @collaborator.email, inviter: @owner, invitee: @collaborator, collaborateable: @board, status: :pending)
    duplicate_invitation = Invitation.create(inviter: @owner, email: @collaborator.email, collaborateable: @board)
    assert_not duplicate_invitation.valid?
  end

  test "should allow new invitation if previous was declined" do
    first_invitation = Invitation.create(email: @non_collaborator.email, inviter: @owner, collaborateable: @board)
    first_invitation.status_is_declined!

    new_invitation = Invitation.create(email: @non_collaborator.email, inviter: @owner, collaborateable: @board)
    assert new_invitation.valid?
  end

  test "should set invitee_id if user exists" do
    invitation = Invitation.create(inviter: @owner, email: @non_collaborator.email, collaborateable: @board)
    assert_equal invitation.invitee_id, @non_collaborator.id
  end

  test "should have null invitee_id if user does not exist" do
    invitation = Invitation.create(inviter: @owner, email: "newuser@example.com", collaborateable: @board)
    assert_nil invitation.invitee_id
  end
end
