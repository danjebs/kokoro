module Invitations
  class Listing < ViewComponent::Base
    with_collection_parameter :invitation

    def initialize(invitation:)
      @invitation = invitation
    end

    private

    attr_reader :invitation
  end
end