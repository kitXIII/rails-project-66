# frozen_string_literal: true

class Repository < ApplicationRecord
  include AASM
  extend Enumerize

  has_many :checks, dependent: :destroy
  belongs_to :user, inverse_of: 'repositories'

  validates :github_id, presence: true, uniqueness: true

  enumerize :language, in: %i[ruby]

  aasm column: :fetching_state do
    state :init, initial: true
    state :fetching, :fetched, :failed

    event :fetch do
      transitions from: %i[init fetched failed], to: :fetching
    end

    event :mark_as_fetched do
      transitions from: :fetching, to: :fetched
    end

    event :mark_as_failed do
      transitions to: :failed
    end
  end
end
