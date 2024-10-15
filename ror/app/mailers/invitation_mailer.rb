class InvitationMailer < ApplicationMailer
  def invitation_email(invitation)
    @invitation = invitation
    @inviter = invitation.inviter
    @collaborateable = invitation.collaborateable
    @accept_url = accept_invitation_url(invitation)
    @decline_url = decline_invitation_url(invitation)
    @invitations_url = invitations_url

    mail(to: @invitation.email, subject: "#{@inviter.name} invited you to collaborate on #{@collaborateable.name}")
  end

  private

  def accept_invitation_url(invitation)
    invitation_url(invitation, status: "accepted")
  end

  def decline_invitation_url(invitation)
    invitation_url(invitation, status: "declined")
  end
end
