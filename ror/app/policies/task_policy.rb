class TaskPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present? && record.board.creator == user
  end

  def new?
    user.present?
  end

  def edit?
    user.present? && record.board.creator == user
  end

  def create?
    new?
  end

  def update?
    edit?
  end

  def destroy?
    user.present? && record.creator == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end