# frozen_string_literal: true

module Linter
  class JavascriptLinter < BaseLinter
    def command
      "node --no-warnings \
        #{Rails.root.join('node_modules/.bin/eslint')} . \
        -c #{Rails.root.join('lib/linter/configs/eslint.config.js')} \
        -f json"
    end

    def build_files_with_flaws(result, work_dir_path)
      result
        .reject { |file| file['errorCount'].zero? }
        .map do |file|
          flaws = file['messages'].map do |m|
            build_flaw(
              rule: m['ruleId'],
              message: m['message'],
              location: "#{m['line']}:#{m['column']}"
            )
          end

          build_file(path: file['filePath'].sub!(work_dir_path.to_s, ''), flaws:)
        end
    end
  end
end
