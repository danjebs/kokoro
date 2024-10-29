class CommentPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    false
  end

  def new?
    user_has_access?
  end

  def edit?
    user_is_owner?
  end

  def create?
    record.commentable.accessible_by?(user)
    # user_has_access?
  end

  def update?
    user_is_owner?
  end

  def destroy?
    user_is_owner?
  end

  private

  def user_has_access?
    record.commentable.accessible_by?(user)
  end

  def user_is_owner?
    record.user == user
  end

  # TODO: see how to implement
  # class Scope < Scope
  #   def resolve
  #     # scope.joins(:commentable).merge(Commentable.accessible_by(user))
  #   end
  # end
end
