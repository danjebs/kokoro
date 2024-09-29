class TaskPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present? && Task.accessible_by(user).exists?(record.id)
  end

  def new?
    user.present?
  end

  def edit?
    user.present? && Task.accessible_by(user).exists?(record.id)
  end

  def create?
    user.present? && record.board.users.include?(user)
  end

  def update?
    edit?
  end

  def destroy?
    user.present? && record.creator == user
  end

  class Scope < Scope
    def resolve
      scope.accessible_by(user)
    end
  end
end