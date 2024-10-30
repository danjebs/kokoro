class Invitation < ApplicationRecord
  belongs_to :invitee, class_name: "User", optional: true
  belongs_to :inviter, class_name: "User"
  belongs_to :collaborateable, polymorphic: true

  enum :status, { pending: "pending", accepted: "accepted", declined: "declined" }, prefix: :status_is

  validates :email, format: { with: Devise.email_regexp }
  validate :inviter_must_be_owner
  validate :invitee_cannot_already_have_access
  validate :email_must_be_unique_unless_declined

  before_validation :set_defaults, on: :create

  scope :from_user, -> (from) { where(inviter: from) }
  scope :for_user, -> (user) { where(invitee: user).or(where(email: user.email)) }
  scope :accessible_by, -> (user) { from_user(user).or(for_user(user)) }

  def email=(value)
    self[:email] = value
    self.invitee_id = User.find_by(email: value)&.id if value.present?
  end

  private

  def set_defaults
    self.status = :pending
  end

  def inviter_must_be_owner
    unless inviter.has_role?(:owner, collaborateable)
      errors.add(:inviter, "must be the #{collaborateable_type} owner")
    end
  end

  def email_must_be_unique_unless_declined
    if collaborateable.invitations.not_status_is_declined.where(email: self.email).where.not(id: self.id).exists?
      errors.add(:email, "already has a pending or accepted invitation for this #{collaborateable_type}")
    end
  end

  def invitee_cannot_already_have_access
    if invitee && status_is_pending? && collaborateable.users.exists?(invitee.id)
      errors.add(:email, "already has access to this #{collaborateable_type}")
    end
  end
end
