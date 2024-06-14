# frozen_string_literal: true

class Repository::Check::File < ApplicationRecord
  belongs_to :check
  has_many :flaws, dependent: nil

  def url
    check&.repository && check&.commit_id ? [check.repository.html_url, 'tree', check.commit_id, path].join('/') : ''
  end
end
