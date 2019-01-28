require 'file_stats'

RSpec.describe FileStats do
  let(:test_file) { 'spec/fixtures/files/ruby.jpg' }
  let(:stats) { FileStats.new(test_file) }

  context '#new' do
    context 'with a bad file path' do
      it 'throws error' do
        expect { FileStats.new('foo') }.to raise_error(RuntimeError, /foo/)
      end
    end

    context 'with a good file path' do
      it 'initialises well' do
        expect { FileStats.new(test_file) }.not_to raise_error
      end
    end
  end

  context '#message' do
    it 'contains one_bits and zero_bits info' do
      expect(stats.send(:message)).to include(stats.one_bits.to_s,
                                              stats.zero_bits.to_s)
    end
  end

  context '#count_bits' do
    it 'counts right' do
      cross_test_val = `wc -c '#{test_file}' | awk '{print $1*8}'`.to_i
      expect(cross_test_val).to eq(stats.one_bits + stats.zero_bits)
    end
  end
end