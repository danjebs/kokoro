module Invitations
  class Listing < BaseComponent
    with_collection_parameter :invitation

    def initialize(invitation:)
      @invitation = invitation
    end

    private

    attr_reader :invitation
  end
end