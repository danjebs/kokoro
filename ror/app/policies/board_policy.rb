class BoardPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present? && record.creator == user
  end

  def new?
    user.present? && record.creator == user
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
      scope.all
    end
  end
end