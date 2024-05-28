# frozen_string_literal: true

module Linter
  module Ruby
    def self.command
      "rubocop -f json -c #{Rails.root.join('lib/linter/configs/rubocop.yml')}"
    end

    def self.transform(result, _work_dir_path)
      result['files']
        .reject { |file| file['offenses'].empty? }
        .map do |file|
          flaws = file['offenses'].map do |offense|
            Linter::Flaw.new(
              rule: offense['cop_name'],
              message: offense['message'],
              location: "#{offense['location']['line']}:#{offense['location']['column']}"
            )
          end

          Linter::File.new(path: file['path'], flaws:)
        end
    end
  end
end
