# frozen_string_literal: true

module RepositoryCheckHelperStub
  class << self
    def prepare_work_dir(*); end

    def clean_work_dir_if_exists(*); end

    def clone_repo(*)
      '13e806c'
    end

    def run_check(*)
      {
        files: [
          {
            path: 'Gemfile',
            offenses: [
              {
                message: "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
                cop_name: 'Style/StringLiterals',
                location:
                  {
                    line: 8,
                    column: 5
                  }
              }
            ]
          },
          {
            path: 'abc.gemspec',
            offenses: [
              {
                message: "`metadata['rubygems_mfa_required']` must be set to `'true'`.",
                cop_name: 'Gemspec/RequireMFA',
                location:
                  {
                    line: 1,
                    column: 15
                  }
              }
            ]
          }
        ]
      }
    end
  end
end
