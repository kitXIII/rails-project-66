# frozen_string_literal: true

class Repository::Check::File < ApplicationRecord
  belongs_to :check
  has_many :flaws # rubocop:disable Rails/HasManyOrHasOneDependent

  def url
    check&.repository && check&.commit_id ? [check.repository.html_url, 'tree', check.commit_id, path].join('/') : ''
  end
end
