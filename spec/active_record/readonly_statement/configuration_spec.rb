RSpec.describe ActiveRecord::ReadonlyStatement::Configuration do
  let(:config) { ActiveRecord::ReadonlyStatement::Configuration.new }

  describe '#adapter=' do
    subject { config.adapter = adapter }

    context 'when adapter is a class' do
      let(:adapter) { ActiveRecord::ConnectionAdapters::DummyAdapter }
      it 'will prepend to the class' do
        expect(adapter).to receive(:prepend).with(ActiveRecord::ConnectionAdapters::ReadonlyDatabaseStatements)
        subject
      end
    end

    context 'when adapter is the mysql2' do
    end
  end
end
