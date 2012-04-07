require 'sinatra/base'
require 'haml'
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
    reponse = ""
    if site.empty?
      response = "No URL given..."
    else
      if content = Page.fetch_page(site)
        frequency = Frequency.count_frequency(content, keywords)
        response = options.classifier.classify(frequency)
      else
        response = "URL not valid, did you forget to add http/https?"
      end
    end
    haml :home, locals: {result: response, site: site}
  end

end
