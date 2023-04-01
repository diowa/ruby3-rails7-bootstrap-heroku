class ArticlePolicy < ApplicationPolicy
  def show?
    true
  end

  def destroy?
    user&.administrator?
  end
end
