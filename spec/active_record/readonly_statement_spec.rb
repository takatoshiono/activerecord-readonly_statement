RSpec.describe ActiveRecord::ReadonlyStatement do
  it "has a version number" do
    expect(ActiveRecord::ReadonlyStatement::VERSION).not_to be nil
  end

  describe '.configuration' do
    it 'yield config instance' do
      ActiveRecord::ReadonlyStatement.configuration do |config|
        expect(config).to be_instance_of ActiveRecord::ReadonlyStatement::Configuration
      end
    end
  end
end
