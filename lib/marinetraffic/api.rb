require 'faraday'
require 'json'

API_URL = "http://services.marinetraffic.com/api"

module Marinetraffic
  class API
    def self.call(name, params = {})
      params[:protocol] = :json
      param_string = params.map{|attr| "#{attr.first}:#{attr.last}"}.join('/')
      url = "#{API_URL}/#{name}/#{Marinetraffic.api_key}/#{param_string}"
      response = Faraday.get(url)
    end
  end
end