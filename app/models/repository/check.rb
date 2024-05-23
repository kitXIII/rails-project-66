# frozen_string_literal: true

class Repository::Check < ApplicationRecord
  include AASM

  belongs_to :repository
  has_many :files, dependent: :destroy
  has_many :flaws, dependent: :destroy

  scope :ordered_by_created_at, -> { order(created_at: :desc) }

  aasm column: :state do
    state :init, initial: true
    state :in_progress, :finished, :failed

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

  def result_success?
    finished? && flaws.empty?
  end

  def commit_url
    repository && commit_id ? [repository.url, 'commit', commit_id].join('/') : ''
  end
end
