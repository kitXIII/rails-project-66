# frozen_string_literal: true

module Web::Repositories::ChecksHelper
  def link_to_commit(check)
    check.commit_id ? link_to(check.commit_id, check.commit_url, target: :blank) : ''
  end

  def link_to_file(file)
    link_to(file.path, file.url, target: :blank)
  end
end
