require 'ai4r'
require './lib/page'
require './lib/frequency'
require './lib/techdata'

class Classifier

  include TechData

  attr_accessor :keys, :net, :max_times_training

  MAX_TIMES = 1000

  def initialize(keys=keywords,max_times_training=MAX_TIMES)
    @keys,@max_times_training = keys,max_times_training
    @net = Ai4r::NeuralNetwork::Backpropagation.new([keys.size,2])
    train_network
  end

  def train_network
    @max_times_training.times do
      # Positive data
      @net.train(Array.new(@keys.size, 1),[1,0])
      @net.train(Array.new(@keys.size, 5),[1,0])
      # Negative data
      @net.train(Array.new(@keys.size, 0),[0,1])
    end
  end

  def classify(raw_data)
    data = transform(raw_data)
    result_label(net.eval(data))
  end

  def transform(raw_data)
    data = []
    @keys.each{|key| data << raw_data[key]}
    data
  end

  def result_label(result)
    if result[0] > result[1] or result[0] > 0.9
      "YES"
    else    
      "NO"
    end
  end
end
