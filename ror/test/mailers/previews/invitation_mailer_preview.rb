class InvitationMailerPreview < ActionMailer::Preview
  def invitation_email
    # Find or create a sample invitation to use in the preview
    invitation = Invitation.first || Invitation.new(
      email: 'test@example.com',
      inviter: User.first || User.new(name: 'John Doe', email: 'john.doe@example.com'),
      collaborateable: Board.first || Board.new(name: 'Sample Board')
    )

    InvitationMailer.invitation_email(invitation)
  end
end
