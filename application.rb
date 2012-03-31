require 'sinatra'

get '/' do
  haml :home
end

post '/' do
  site = params[:site]
  puts site
  haml :home
end
