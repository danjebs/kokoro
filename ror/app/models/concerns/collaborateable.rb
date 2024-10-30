module Collaborateable
  extend ActiveSupport::Concern

  included do
    has_many :invitations, as: :collaborateable, dependent: :destroy

    after_create :add_creator_as_owner

    scope :accessible_by, ->(user) {
      return none if user.nil?

      joins(:users).where(users: { id: user.id })
    }

    def add_collaborator(user)
      user.add_role(:collaborator, self)
    end

    def users_with_access
      User.with_role(:owner, self).or(User.with_role(:collaborator, self))
    end

    private

      def add_creator_as_owner
        creator.add_role :owner, self
      end
  end
end
