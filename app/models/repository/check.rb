# frozen_string_literal: true

class Repository::Check < ApplicationRecord
  include AASM

  belongs_to :repository
  has_many :files, dependent: :destroy
  has_many :flaws, dependent: :destroy

  scope :ordered_by_created_at, -> { order(created_at: :desc) }

  aasm do
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

  def commit_url
    repository && commit_id ? [repository.html_url, 'commit', commit_id].join('/') : ''
  end
end
