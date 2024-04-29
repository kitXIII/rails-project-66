# frozen_string_literal: true

class Repository::Check < ApplicationRecord
  include AASM

  belongs_to :repository

  aasm column: :state do
    state :init, initial: true
    state :fetching, :fetched, :checking, :checked, :failed

    event :fetch do
      transitions from: %i[init failed], to: :fetching
    end

    event :mark_as_fetched do
      transitions from: :fetching, to: :fetched
    end

    event :check do
      transitions from: :fetched, to: :checking
    end

    event :mark_as_checked do
      transitions from: :checking, to: :checked
    end

    event :mark_as_failed do
      transitions to: :failed
    end
  end
end
