module Collaborateable
  extend ActiveSupport::Concern

  included do
    has_many :invitations, as: :collaborateable, dependent: :destroy
  end
end
