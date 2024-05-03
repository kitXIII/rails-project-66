# frozen_string_literal: true

class RepositoryPolicy < ApplicationPolicy
  def create?
    user && record.user == user
  end
end
