# frozen_string_literal: true

class Repository::Check < ApplicationRecord
  include AASM

  belongs_to :repository

  aasm column: :state do
    state :init, initial: true
    state :in_progress, :on_error, :finished, :failed

    event :start do
      transitions from: :init, to: :in_progress
    end

    event :finish do
      transitions from: :in_progress, to: :finished
    end

    event :fail do
      transitions to: :failed
    end
  end
end
