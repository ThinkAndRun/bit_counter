class FileStats
  attr_reader :one_bits, :zero_bits

  def initialize(path)
    raise "The file #{path} doesn't exist" unless File.exists?(path.to_s)
    @one_bits = 0
    @zero_bits = 0
    count_bits(path)
  end

  def print
    puts message
  end

  private

  def count_bits(path)
    File.open(path, 'rb').each do |line|
      l = line.unpack('B*').to_s
      @one_bits += l.count('1')
      @zero_bits += l.count('0')
    end
  end

  def message
    "found #{@one_bits} bits set to 1\n" \
    "found #{@zero_bits} bits set to 0"
  end
end