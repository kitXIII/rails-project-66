# frozen_string_literal: true

module Linter
  Flaw = Struct.new(:rule, :message, :location)
  File = Struct.new(:path, :flaws)

  class BaseLinter
    def build_flaw(rule:, message:, location:)
      Linter::Flaw.new(rule:, message:, location:)
    end

    def build_file(path:, flaws:)
      Linter::File.new(path:, flaws:)
    end

    def command
      raise NotImplementedError
    end

    def build_files_with_flaws
      raise NotImplementedError
    end
  end
end
