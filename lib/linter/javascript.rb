# frozen_string_literal: true

module Linter
  module Javascript
    def self.command
      "node --no-warnings #{Rails.root.join('node_modules/.bin/eslint')} . \
        -c #{Rails.root.join('lib/linter/configs/eslint.config.js')} -f json"
    end

    def self.transform(result, work_dir_path)
      result
        .reject { |file| file['errorCount'].zero? }
        .map do |file|
          flaws = file['messages'].map do |m|
            Linter::Flaw.new(
              rule: m['ruleId'],
              message: m['message'],
              location: "#{m['line']}:#{m['column']}"
            )
          end

          Linter::File.new(path: file['filePath'].sub!(work_dir_path.to_s, ''), flaws:)
        end
    end
  end
end
