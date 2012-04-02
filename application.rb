require 'sinatra'
require './lib/page'

get '/' do
  haml :home
end

post '/' do
  site = params[:site]
  if content = Page.fetch_page(site)
    haml :home, locals: {result: "YES", site: site}
  else
    haml :home, locals: {result: "NO", site: site}
  end
end
