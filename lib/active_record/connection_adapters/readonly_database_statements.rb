class ActiveRecord::ReadonlyStatementError < StandardError; end

module ActiveRecord
  module ConnectionAdapters
    module ReadonlyDatabaseStatements
      def execute(sql, name = nil)
        if ActiveRecord::ReadonlyStatement.enable?
            if sql =~ /^(SELECT|SET|SHOW|DESCRIBE)\b/
              super sql, name
            else
              raise ActiveRecord::ReadonlyStatementError, "#{name}: #{sql}"
            end
        else
            super sql, name
        end
      end
    end
  end
end
