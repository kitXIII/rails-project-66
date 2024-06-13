# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/repository_check_mailer
class RepositoryCheckMailerPreview < ActionMailer::Preview
  def repository_check_failed
    RepositoryCheckMailer.check_failed_email(Repository::Check.first.id)
  end

  def repository_check_found_flaws
    RepositoryCheckMailer.check_found_flaws_email(Repository::Check.where.not(flaws_count: 0).first.id)
  end
end
