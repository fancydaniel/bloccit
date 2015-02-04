class FavoritePolicy < ApplicationPolicy

  def create?
    user.present?
  end

end