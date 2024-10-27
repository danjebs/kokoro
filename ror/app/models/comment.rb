class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :commentable, presence: true
  validates :user, presence: true
  validates :content, presence: true
  validate :user_has_access_to_commentable
  validate :user_id_unchanged, on: :update

  def accessible_by?(user)
    commentable.accessible_by?(user)
  end

  private

  def user_has_access_to_commentable
    return unless commentable && user

    unless commentable.accessible_by?(user)
      errors.add(:user, "does not have access to the #{commentable_type}")
    end
  end

  def user_id_unchanged
    if user_id_changed? && self.persisted?
      errors.add(:user_id, "cannot be changed once set")
    end
  end
end
