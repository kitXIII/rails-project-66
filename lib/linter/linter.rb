# frozen_string_literal: true

module Linter
  File = Struct.new(:path, :flaws)
  Flaw = Struct.new(:rule, :message, :location)
  Result = Struct.new(:files)
end
