require 'faraday'
require 'nokogiri'

API_URL = "http://services.marinetraffic.com/api"

module Marinetraffic
  class API
    def self.call(name, params = {})
      params[:protocol] = :xml
      param_string = params.map{|attr| "#{attr.first}:#{attr.last}"}.join('/')
      url = "#{API_URL}/#{name}/#{Marinetraffic.api_key}/#{param_string}"
      response = Faraday.get(url)
      doc = Nokogiri::XML(response.body)
      raise_exception(doc) if doc.xpath('//ERROR').any?
      doc
    end

    def self.raise_exception(doc)
      message = doc.xpath("//ERROR")[0]['DESCRIPTION']
      raise MarinetrafficException.new(message)
    end
  end

  class MarinetrafficException < Exception
  end
end
