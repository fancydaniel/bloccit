class PostPolicy < ApplicationPolicy

  def index?
    true
  end

  # def update?
  #   user.admin? or not post.published?
  # end

end