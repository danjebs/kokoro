# frozen_string_literal: true

class DashboardPolicy < ApplicationPolicy
  def initialize(user, record)
    if user.nil?
      raise Pundit::NotAuthorizedError, "must be logged in"
    end

    @user   = user
    @record = record
  end
end
