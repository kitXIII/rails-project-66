# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@kitxiii-github-quality.onrender.com'
  layout 'mailer'

  helper Web::Repository::CheckHelper
end
