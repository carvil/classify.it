require File.join(File.dirname(__FILE__), 'spec_helper')

describe Classifier do
  describe ".new" do
    context "given a set of keys" do
      it "should save the keys, create and train a network" do
        Classifier.any_instance.should_receive(:train_network).and_return(true)
        classifier = Classifier.new(["k1","k2"], 10)
        classifier.keys.should eq(["k1","k2"])
        classifier.net.should_not be_nil
        classifier.max_times_training.should eq(10)
      end
    end

    context "given no arguments" do
      it "should create a network" do
        subject.keys.should eq(subject.keywords)
        subject.net.should_not be_nil
      end
    end
  end

  describe "#transform" do
    context "given frequencies" do
      it "should transform into an array" do
        Classifier.any_instance.should_receive(:train_network).and_return(true)
        classifier = Classifier.new(["k1","k2"], 10)
        classifier.transform({"k1" => 2, "k2" => 9}).should eq([2, 9])
      end
    end
  end

  describe "#result_label" do
    context "given a result array with positive data" do
      it "should return YES" do
        subject.result_label([0.905332399962579, 0.7994715053020781]).should eq("YES")
      end
    end

    context "given a result array with negative data" do
      it "should return NO" do
        subject.result_label([0.7994715053020781, 0.9053323999625797]).should eq("NO")
      end
    end
  end

  describe ".classify" do

    let(:classif) {
      Classifier.new(["k1","k2","k3","k4","k5","k6"], 100)
    }

    context "given positive frequencies" do
      it "should return YES" do
        classif.classify({"k1" => 5, "k2" => 8, "k3" => 1, "k4" => 12, "k5" => 10, "k6" => 5}).should eq("YES")
      end
    end

    context "given negative frequencies" do
      it "should return NO" do
        classif.classify({"k1" => 0, "k2" => 0, "k3" => 0, "k4" => 0, "k5" => 0, "k6" => 0}).should eq("NO")
      end
    end
  end
end
