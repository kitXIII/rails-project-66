# frozen_string_literal: true

Repo = Struct.new(:id, :name, :full_name, :language, :html_url, :clone_url)

class OctokitClientStub
  REPOS = [
    Repo.new(123_456_789, 'aaa', 'owner/aaa', 'Ruby', 'https://github.com/owner/aaa', 'https://github.com/owner/aaa.git'),
    Repo.new(234_567_891, 'bbb', 'owner/bbb', 'Ruby', 'https://github.com/owner/bbb', 'https://github.com/owner/bbb.git'),
    Repo.new(345_678_912, 'ccc', 'owner/ccc', 'Go', 'https://github.com/owner/ccc', 'https://github.com/owner/ccc.git')
  ].freeze

  def initialize(*); end

  def repos(*)
    REPOS
  end

  def repo(*)
    REPOS.first
  end

  def create_hook(*); end
end
