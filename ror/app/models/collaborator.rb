class Collaborator < ApplicationRecord
  belongs_to :collaborateable, polymorphic: true
  belongs_to :user

  validates :user_id,
    uniqueness: { scope: [:collaborateable_type, :collaborateable_id],
    message: "is already a collaborator for this item" }
end
