class TicketPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    user.try(:admin?) || record.project.roles.exists?(user_id: user)
  end

  def create?
    user.try(:admin?) || record.project.has_manager?(user) || record.project.has_editor?(user)
  end
end
