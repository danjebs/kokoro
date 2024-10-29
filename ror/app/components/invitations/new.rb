module Invitations
  class New < BaseComponent
    def initialize(invitation:)
      @invitation = invitation
    end

    private

    attr_reader :invitation
  end
end