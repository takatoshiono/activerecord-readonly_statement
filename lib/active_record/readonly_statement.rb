require "active_record/readonly_statement/configuration"
require "active_record/readonly_statement/version"

module ActiveRecord
  class ReadonlyStatement
    @@config = nil

    def self.configuration
      @@config = Configuration.new
      yield @@config
    end

    def self.config
      @@config
    end
  end
end
