require 'uri'
require 'faraday'

class Page

  attr_accessor :url, :uri, :conn

  def initialize(url)
    @url = url
  end

  def self.fetch_page(url)
    page = Page.new(url)
    if page.valid?
      page.download
    end
  end

  def valid?
    %w( http https ).include?(uri.scheme) if uri
  end

  def uri
    @uri ||= URI.parse(url)
  rescue URI::InvalidURIError
    nil
  end

  def download
    response = conn.get "#{uri.path}"
    response.body
  rescue SocketError
    nil
  end

  def conn
    @conn ||= Faraday.new(:url => "#{uri.scheme}://#{uri.host}") do |builder|
      builder.adapter  :net_http
    end
  end
end
