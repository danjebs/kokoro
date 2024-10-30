require "test_helper"

class InvitationFlowTest < ActionDispatch::IntegrationTest
  setup do
    @invitation = invitations(:bundy_invites_bean_to_board_two)
    @inviter = users(:bundy)
    @invitee = users(:bean)
    @non_existent_user_email = "pinkmama@yopmail.com"
  end

  test "flow for invited user that exists and is logged in" do
    sign_in @invitee
    get invitation_url(@invitation)
    assert_response :success

    patch invitation_url(@invitation), params: { invitation: { status: :accepted } }

    assert @invitation.collaborateable.users_with_access.exists?(@invitee.id)
    assert_equal @invitee.id, @invitation.reload.invitee_id

    assert_redirected_to @invitation.collaborateable
    follow_redirect!
    assert_response :success
  end

  test "flow for invited user that exists but is not logged in" do
    get invitation_url(@invitation)
    assert_redirected_to new_user_session_url()

    sign_in @invitee
    follow_redirect!
    assert_redirected_to invitation_url(@invitation)

    follow_redirect!
    assert_response :success
  end

  test "flow for invited user that does not exist" do
    invitation = invitations(:nonexistent_invitee)

    get invitation_url(invitation)
    assert_redirected_to new_user_session_url()

    get new_user_registration_url
    post user_registration_url, params: {
      user: {
        name: "Dobby",
        email: invitation.email,
        password: "password",
        password_confirmation: "password"
      }
    }

    assert_redirected_to invitation_url(invitation)

    follow_redirect!
    assert_response :success
  end

  test "email is sent with correct invitation URL" do
    sign_in @inviter
    assert_emails 1 do
      post invitations_url, params: {
        invitation: {
          collaborateable_id: @invitation.collaborateable_id,
          collaborateable_type: @invitation.collaborateable_type,
          email: @non_existent_user_email
        }
      }
    end

    email = ActionMailer::Base.deliveries.last
    assert_equal [@non_existent_user_email], email.to
    assert_match invitation_url(Invitation.last), email.body.to_s
  end
end
