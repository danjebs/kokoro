class Collaborator < ApplicationRecord
  belongs_to :collaborateable, polymorphic: true
  belongs_to :user
  belongs_to :inviter, class_name: "User"
end
