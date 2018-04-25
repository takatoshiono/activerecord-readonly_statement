module ActiveRecord
  class ReadonlyStatement
    class Configuration
      attr_reader :enable_if_block

      def adapter=(adapter)
        @adapter = adapter
        prepend_readonly
      end

      def enable_if(&block)
        @enable_if_block = block
      end

      private

      def prepend_readonly
        adapter_class.prepend(ActiveRecord::ConnectionAdapters::ReadonlyDatabaseStatements)
      end

      def adapter_class
        case @adapter
        when Class
          @adapter
        else
          raise ArgumentError, "Unexpected adapter: #{@adapter}"
        end
      end
    end
  end
end
