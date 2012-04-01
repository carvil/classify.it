require File.join(File.dirname(__FILE__), 'spec_helper')
require File.join(File.dirname(__FILE__), '..', 'lib', 'page')

describe Page do
  describe ".fetch_page" do
    use_vcr_cassette

    context "given a valid url" do
      it "should return the page" do
        page = Page.fetch_page("http://dash-it-app.herokuapp.com")
        page.should_not be_nil
        page.should eq("<html><body>You are being <a href=\"http://dash-it-app.herokuapp.com/projects\">redirected</a>.</body></html>")
      end
    end

    context "given an invalid url" do
      it "should return nil" do
        Page.fetch_page('http://this.is.an.invalid.url').should be_nil
        Page.fetch_page('this is invalid').should be_nil
        Page.fetch_page('').should be_nil
        Page.fetch_page(nil).should be_nil
        Page.fetch_page(123).should be_nil
        Page.fetch_page([]).should be_nil
      end
    end
  end

  describe "#valid?" do
    context "given a valid url" do
      it "should return true" do
        Page.new("http://carvil.github.com/Programming/2012/03/18/replacing-rails-views-with-ember-js/").valid?.should be_true
      end
    end

    context "given an invalid url" do
      it "should be false" do
        Page.new("invalid").valid?.should be_false
      end
    end
  end

  describe "#download" do
    use_vcr_cassette
    context "given a valid url" do
      it "should download the page" do
        Page.new("http://dash-it-app.herokuapp.com").download.should eq("<html><body>You are being <a href=\"http://dash-it-app.herokuapp.com/projects\">redirected</a>.</body></html>")
      end
    end

    context "given an invalid url" do
      it "should return an error text" do
        Page.new("http://this.is.an.invalid.url").download.should be_nil
      end
    end
  end
end
