module Marinetraffic
  class Subscription
    attr_accessor :api_key

    def initialize(api_key)
      @api_key = api_key
    end

    def find(mmsi, extended = false, options = {})
      params = { api_key: api_key }.merge(options)
      params[:msgtype] = :extended if extended
      response = API.call(:exportvessels, params)
      result = response.xpath("//row[@MMSI=#{mmsi}]")[0]

      if result != nil
        attributes = Marinetraffic::Vessel.map_attributes(result, extended)
        Marinetraffic::Vessel.new(attributes)
      end
    end

    def all(extended = false, options = {})
      params = { timespan: 20, api_key: api_key }.merge(options)
      params[:msgtype] = :extended if extended
      response = API.call(:exportvessels, params)
      result = response.xpath("//row").map do |row|
        attributes = Marinetraffic::Vessel.map_attributes(row, extended)
        Marinetraffic::Vessel.new(attributes)
      end
    end
  end
end
