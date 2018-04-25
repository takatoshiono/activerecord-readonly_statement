module ActiveRecord
  class ReadonlyStatement
    class Middleware
      def initialize(app)
        @app = app
      end

      def call(env)
        if enable?(env)
          ActiveRecord::ReadonlyStatement.enable!
        end

        @app.call(env)
      ensure
        ActiveRecord::ReadonlyStatement.disable!
      end

      private

      def enable?(env)
        c = ActiveRecord::ReadonlyStatement.config
        c && c.enable_if_block.call(env)
      end
    end
  end
end
