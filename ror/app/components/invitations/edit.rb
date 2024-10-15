module Invitations
  class Edit < ViewComponent::Base
    def initialize(invitation:)
      @invitation = invitation
    end
  end
end
