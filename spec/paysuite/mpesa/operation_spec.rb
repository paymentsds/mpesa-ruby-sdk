RSpec.describe Paysuite::MPesa::Operation do
  describe '#valid?' do
    it 'should not be valid' do
      operation = Paysuite::MPesa::Operation.new do |o|
        o.method = 'put'
      end

      expect(operation.valid?).to eq(false)
    end

    it 'should be valid' do
      operation = Paysuite::MPesa::Operation.new do |o|
        o.method = 'post'
        o.port = 1456
        o.requires = [
          'to',
          'from'
        ]
      end

      expect(operation.valid?).to eq(true)
    end
  end
end
