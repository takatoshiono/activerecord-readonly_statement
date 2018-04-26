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
      Thread.current['activerecord-readonly_statement-enabled'] = true
    end

    def self.disable!
      Thread.current['activerecord-readonly_statement-enabled'] = false
    end

    def self.enable?
      Thread.current['activerecord-readonly_statement-enabled']
    end
  end
end
