# frozen_string_literal: true

module RepositoryCheckHelper
  class << self
    def prepare_work_dir(work_dir_path)
      clean_work_dir_if_exists(work_dir_path)
      FileUtils.mkdir_p(work_dir_path)
    end

    def clean_work_dir_if_exists(work_dir_path)
      FileUtils.rm_rf(work_dir_path) if work_dir_path.exist?
    end

    def clone_repo(repo_clone_url, work_dir_path)
      _, _, status = Open3.capture3("git clone #{repo_clone_url} .", chdir: work_dir_path)
      raise 'Git clone failed' unless status.success?

      r, _, status = Open3.capture3('git log --format="%h" -n 1', chdir: work_dir_path)
      raise 'Git log failed' unless status.success?

      r.chomp
    end

    def run_check(command, work_dir_path)
      r, = Open3.capture3(command, chdir: work_dir_path)

      JSON.parse(r)
    end
  end
end
