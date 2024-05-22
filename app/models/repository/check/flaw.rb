# frozen_string_literal: true

class Repository::Check::Flaw < ApplicationRecord
  belongs_to :check
  belongs_to :file
end
