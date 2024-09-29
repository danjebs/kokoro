class BoardPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present? && Board.accessible_by(user).exists?(record.id)
  end

  def new?
    user.present?
  end

  def edit?
    user.present? && record.creator == user
  end

  def create?
    new?
  end

  def update?
    edit?
  end

  def destroy?
    false
  end

  class Scope < Scope
    def resolve
      scope.accessible_by(user)
    end
  end
end