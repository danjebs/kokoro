class TaskStatusPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present? && record.board.creator == user
  end

  def create?
    user.present?
  end

  def update?
    user.present? && record.board.creator == user
  end

  def destroy?
    false
  end
end