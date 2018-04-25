module ActiveRecord
  class ReadonlyStatement
    class Configuration
      attr_reader :enable_if_block

      def adapter=(adapter)
        @adapter = adapter
      end

      def enable_if(&block)
        @enable_if_block = block
      end
    end
  end
end
