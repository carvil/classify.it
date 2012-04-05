require File.join(File.dirname(__FILE__), 'spec_helper')

describe Frequency do

  let(:subject) {
    Frequency.new("text about technology", ["technology"])
  }

  let(:invalid) {
    Frequency.new(nil, nil)
  }

  describe ".count_frequency" do
    context "given a text and an array of keys" do
      it "should return a hash of work occurrencies that are in the keys array" do
        Frequency.count_frequency("this is an example text about technology", ["technology", "text"]).should eq({"text"=>1, "technology"=>1})
      end
    end

    context "given a text and an array of keys that are not present in the text" do
      it "should return an empty hash" do
        Frequency.count_frequency("this is an example", ["technology", "text"]).should eq({"technology"=>0, "text"=>0})
      end
    end

    context "given a text and an empty array" do
      it "should return an empty hash" do
        Frequency.count_frequency("this is an example", []).should eq({})
      end
    end
  end

  describe "#words" do
    context "given a text" do
      it "should devide it by words" do
        subject.words.should eq(["text", "about", "technology"])
      end
    end

    context "given no text" do
      it "should return nil" do
        invalid.words.should be_nil
      end
    end
  end

  describe "#frequencies" do
    context "given a text and a set of keys" do
      it "should return a hash of frequencies for those keys" do
        subject.frequencies.should eq({"technology"=>1})
      end
    end

    context "given no text" do
      it "should return nil" do
        invalid.frequencies.should be_nil
      end
    end
  end
end
