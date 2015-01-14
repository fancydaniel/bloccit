class PostPolicy < ApplicationPolicy

  def index?
    true
  end

  def destroy?
    user.present? && (record.user == user || user.admin? || user.moderator?) #can_moderate?
  end

  def update?
    user.admin? or not post.published?
  end

end