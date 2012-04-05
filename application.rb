require 'sinatra/base'
require './lib/page'
require './lib/frequency'
require './lib/classifier'
require './lib/techdata'

class TechClassifier < Sinatra::Base

  # Include the keywords
  include TechData

  # Initialize the classifier
  set :classifier, Classifier.new

  # Main page
  get '/' do
    haml :home
  end

  # Classify a url
  post '/' do
    site = params[:site]
    if content = Page.fetch_page(site)
      frequency = Frequency.count_frequency(content, keywords)
      result = options.classifier.classify(frequency)
      haml :home, locals: {result: result, site: site}
    else
      haml :home, locals: {result: result, site: site}
    end
  end

end
