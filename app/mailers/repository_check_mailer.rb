# frozen_string_literal: true

class RepositoryCheckMailer < ApplicationMailer
  def check_failed_email(check_id)
    @check = Repository::Check.find(check_id)
    @repo_name = @check.repository.full_name

    mail(to: @check.repository.user.email, subject: t('.check_failed', repo_name: @repo_name))
  end

  def check_found_flaws_email(check_id)
    @check = Repository::Check.find(check_id)
    @repo_name = @check.repository.full_name

    mail(to: @check.repository.user.email, subject: t('.check_found_flaws', repo_name: @repo_name))
  end
end
