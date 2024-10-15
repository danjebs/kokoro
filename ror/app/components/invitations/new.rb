module Invitations
  class New < ViewComponent::Base
    def initialize(invitation:)
      @invitation = invitation
    end

    private

    attr_reader :invitation
  end
end