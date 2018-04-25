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

      def config
        @config ||= ActiveRecord::ReadonlyStatement.config
      end

      def enable?(env)
        config && config.enable_if_block.call(env)
      end
    end
  end
end
