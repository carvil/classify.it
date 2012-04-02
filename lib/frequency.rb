class Frequency
  attr_accessor :text, :keys, :freqs

  def initialize(text, keys)
    @text, @keys = text, keys
    @freqs = Hash.new(0)
  end

  def self.count_frequency(text, keys)
    freq = Frequency.new(text, keys)
    freq.frequencies
  end

  def words
    text.split(/[^a-zA-Z]/) if text
  end

  def frequencies
    if words
      words.each { |word| freqs[word] += 1 }
      freqs.reject{|k,v| !keys.include?(k)}
    end
  end
end
