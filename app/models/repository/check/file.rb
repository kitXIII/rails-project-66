# frozen_string_literal: true

class Repository::Check::File < ApplicationRecord
  belongs_to :check
  has_many :flaws # rubocop:disable Rails/HasManyOrHasOneDependent
end
