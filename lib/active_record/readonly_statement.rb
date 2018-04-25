require "active_record/connection_adapters/readonly_database_statements"
require "active_record/readonly_statement/configuration"
require "active_record/readonly_statement/middleware"
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

    def self.enable!
      @@enabled = true
    end

    def self.disable!
      @@enabled = false
    end

    def self.enable?
      @@enabled
    end
  end
end
