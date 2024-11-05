class InvitationPolicy < DashboardPolicy
  def index?
    user.present?
  end

  def show?
    record.status_is_pending? && user.present? && (user.in?([record.invitee, record.inviter]) || user.email == record.email)
  end

  def new?
    user.present? && record.present? && record.collaborateable.present? && user.has_role?(:owner, record.collaborateable)
  end

  def edit?
    record.status_is_pending? && user.present? && (user == record.invitee || user.email == record.email)
  end

  def create?
    new?
  end

  def update?
    edit?
  end

  def destroy?
    user == record.inviter
  end

  class Scope < Scope
    def resolve
      scope.accessible_by(user)
    end
  end
end