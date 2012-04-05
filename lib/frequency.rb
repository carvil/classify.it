class Frequency
  attr_accessor :text, :keys, :freqs

  def initialize(text, keys)
    @text, @keys = text, keys
    @freqs = Hash.new(0)
    keys.each{|key| @freqs[key] = 0 } if keys
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
      words.each { |word| freqs[word.downcase] += 1 }
      freqs.reject{|k,v| !keys.include?(k)}
    end
  end

end
