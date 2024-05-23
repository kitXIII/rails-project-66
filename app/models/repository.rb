# frozen_string_literal: true

class Repository < ApplicationRecord
  extend Enumerize

  has_many :checks, dependent: :destroy
  belongs_to :user, inverse_of: 'repositories'

  validates :github_id, presence: true, uniqueness: true

  enumerize :language, in: %i[ruby]

  def url
    clone_url.gsub(/\.git$/, '')
  end
end
