module Invitations
  class List < BaseComponent
    def initialize(invitations:)
      @invitations = invitations
    end

    private

    attr_reader :invitations
  end
end