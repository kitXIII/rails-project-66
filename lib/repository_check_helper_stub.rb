# frozen_string_literal: true

module RepositoryCheckHelperStub
  class << self
    def clean_work_dir_if_exists(*); end

    def clone_repo(*)
      '13e806c'
    end

    def run_check(*)
      {
        'files' => [
          {
            'path' => 'Gemfile',
            'offenses' => []
          },
          {
            'path' => 'abc.gemspec',
            'offenses' => []
          }
        ]
      }
    end
  end
end
