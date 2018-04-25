require 'rack/mock'

RSpec.describe ActiveRecord::ReadonlyStatement::Middleware do
  let(:resp) { 'hello' }
  let(:app) { ->(env) { [200, env, resp] } }

  describe '#call' do
    let(:connection) { ActiveRecord::ConnectionAdapters::DummyAdapter.new }
    subject { Rack::MockRequest.new(ActiveRecord::ReadonlyStatement::Middleware.new(app)).get("/") }

    RSpec.shared_context 'app issues only read queries' do
      let(:app) {
        ->(env) {
          connection.execute "DESCRIBE users", "NAME"
          connection.execute "SELECT * FROM users", "NAME"
          [200, env, resp]
        }
      }
    end

    RSpec.shared_context 'app issues a not read queries' do
      let(:app) {
        ->(env) {
          connection.execute "DESCRIBE users", "NAME"
          connection.execute "SELECT * FROM users", "NAME"
          connection.execute "INSERT INTO users VALUES(1, 'foo')", "NAME"
          [200, env, resp]
        }
      }
    end

    context 'when enable_if block returns true' do
      before do
        ActiveRecord::ReadonlyStatement.configuration do |config|
          config.adapter = ActiveRecord::ConnectionAdapters::DummyAdapter
          config.enable_if { |env| true }
        end
      end

      context 'when issues only read queries' do
        include_context 'app issues only read queries'
        it { expect { subject }.not_to raise_error }
      end

      context 'when issues a not read query' do
        include_context 'app issues a not read queries'
        it { expect { subject }.to raise_error(ActiveRecord::ReadonlyStatementError) }
      end
    end

    context 'when enable_if block returns false' do
      before do
        ActiveRecord::ReadonlyStatement.configuration do |config|
          config.adapter = ActiveRecord::ConnectionAdapters::DummyAdapter
          config.enable_if { |env| false }
        end
      end

      context 'when issues only read queries' do
        include_context 'app issues only read queries'
        it { expect { subject }.not_to raise_error }
      end

      context 'when issues a not read query' do
        include_context 'app issues a not read queries'
        it { expect { subject }.not_to raise_error }
      end
    end

    it 'ensures disable checking readonly'
  end
end
