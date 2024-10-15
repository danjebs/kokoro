module Invitations
  class List < ViewComponent::Base
    def initialize(invitations:)
      @invitations = invitations
    end

    private

    attr_reader :invitations
  end
end