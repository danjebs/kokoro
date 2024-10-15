class Invitation < ApplicationRecord
  belongs_to :invitee, class_name: "User", optional: true
  belongs_to :inviter, class_name: "User"
  belongs_to :collaborateable, polymorphic: true

  attribute :status, :string
  enum status: { pending: "pending", accepted: "accepted", declined: "declined" }, _prefix: :status_is

  validates :email, format: { with: Devise.email_regexp }
  validate :inviter_must_be_collaborator
  validate :email_must_be_unique_unless_declined

  before_validation :set_defaults, on: :create

  scope :accessible_by, -> (user) { where(inviter: user).or(where(invitee: user)) }

  def email=(value)
    self[:email] = value
    self.invitee_id = User.find_by(email: value)&.id if value.present?
  end

  private

  def set_defaults
    self.status = :pending
  end

  def inviter_must_be_collaborator
    unless collaborateable.collaborators.exists?(user: inviter)
      errors.add(:inviter, "must be a collaborator in the collaborateable")
    end
  end

  def email_must_be_unique_unless_declined
    if collaborateable.invitations.not_status_is_declined.where(email: self.email).where.not(id: self.id).exists?
      errors.add(:email, "already has a pending or accepted invitation for this #{collaborateable_type}")
    end
  end
end
