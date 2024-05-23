# frozen_string_literal: true

class Repository::Check::Flaw < ApplicationRecord
  belongs_to :check, counter_cache: :flaws_count
  belongs_to :file
end
