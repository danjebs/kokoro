module Invitations
  class Show < ViewComponent::Base
    def initialize(invitation:, tasks_by_status:)
      @invitation = invitation
      @tasks_by_status = tasks_by_status
    end

    private

    attr_reader :invitation, :tasks_by_status
  end
end