RSpec.describe Paysuite::MPesa::Configuration do
  describe '#generate_access_token' do
    it 'should not set auth' do
      config = Paysuite::MPesa::Configuration.new
      config.generate_access_token
      expect(config.auth).to eq(nil)
    end
  end
end
