# frozen_string_literal: true

module Linter
  class RubyLinter < BaseLinter
    def command
      "rubocop -f json -c #{Rails.root.join('lib/linter/configs/rubocop.yml')}"
    end

    def transform(result, _work_dir_path)
      result['files']
        .reject { |file| file['offenses'].empty? }
        .map do |file|
          flaws = file['offenses'].map do |offense|
            build_flaw(
              rule: offense['cop_name'],
              message: offense['message'],
              location: "#{offense['location']['line']}:#{offense['location']['column']}"
            )
          end

          build_file(path: file['path'], flaws:)
        end
    end
  end
end
