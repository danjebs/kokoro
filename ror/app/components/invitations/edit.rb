class Invitations::Edit < BaseComponent
  def initialize(invitation:)
    @invitation = invitation
  end

  private

  attr_accessor :invitation
end
