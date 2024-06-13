# frozen_string_literal: true

require 'test_helper'

class RepositoryCheckMailerTest < ActionMailer::TestCase
  setup do
    @user = users(:one)
    @repository_check = repository_checks(:one)
  end

  test 'repository check failed' do
    email = RepositoryCheckMailer.check_failed_email(@repository_check.id)

    assert_emails 1 do
      email.deliver_later
    end

    assert { email.from == ['noreply@kitxiii-github-quality.onrender.com'] }
    assert { email.to == [@user.email] }
  end

  test 'repository check found flaws' do
    email = RepositoryCheckMailer.check_found_flaws_email(@repository_check.id)

    assert_emails 1 do
      email.deliver_later
    end

    assert { email.from == ['noreply@kitxiii-github-quality.onrender.com'] }
    assert { email.to == [@user.email] }
  end
end
