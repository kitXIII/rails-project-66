# frozen_string_literal: true

class Repository::Check::File::Problem < ApplicationRecord
  belongs_to :file
end
