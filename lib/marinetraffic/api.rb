require 'faraday'
require 'nokogiri'

module Marinetraffic
  class API
    def self.call(name, params = {})
      api_key = params.delete(:api_key)

      unless api_key ||= Marinetraffic.api_key
        raise AuthenticationError.new('No API key provided. ' \
          'Set your API key using "Marinetraffic.api_key = <API-KEY>" ' \
          'or pass it as parameter to your request.')
      end

      params[:protocol] = :xml
      param_string = params.map{|attr| "#{attr.first}:#{attr.last}"}.join('/')
      url = "#{Marinetraffic.api_base}/#{name}/#{api_key}/#{param_string}"
      response = Faraday.get(url)
      doc = Nokogiri::XML(response.body)
      handle_api_error(response, doc) if doc.xpath('//ERROR').any?
      doc
    end

    def self.handle_api_error(response, doc)
      error = doc.xpath('//ERROR')[0]['DESCRIPTION']
      code = doc.xpath('//ERROR')[0]['CODE']
      raise APIError.new(error, response.status.to_s, response.body, response.headers, code)
    end
  end
end
