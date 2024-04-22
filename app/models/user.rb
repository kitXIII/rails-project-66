# frozen_string_literal: true

class User < ApplicationRecord
  has_many :repositories, dependent: :destroy, inverse_of: 'user'

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP },
                    presence: true,
                    uniqueness: { case_sensitive: false }
end
