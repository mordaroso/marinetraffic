module Marinetraffic
  class Vessel

    attr_reader :mmsi, :lat, :lon, :speed, :course, :status, :timestamp
    attr_reader :ship_type, :ship_name, :imo, :callsign, :flag, :current_port, :last_port, :last_port_time, :destination, :eta, :length, :width, :draught, :grt, :dwt, :year_built

    def initialize(attributes = {})
      @mmsi = attributes["mmsi"]
      @lat = attributes["lat"]
      @lon = attributes["lon"]
      @speed = attributes["speed"]
      @course = attributes["course"]
      @status = attributes["status"]
      @timestamp = attributes["timestamp"]
      @ship_type = attributes["ship_type"]
      @ship_name = attributes["ship_name"]
      @imo = attributes["imo"]
      @callsign = attributes["callsign"]
      @flag = attributes["flag"]
      @current_port = attributes["current_port"]
      @last_port = attributes["last_port"]
      @last_port_time = attributes["last_port_time"]
      @destination = attributes["destination"]
      @eta = attributes["eta"]
      @length = attributes["length"]
      @width = attributes["width"]
      @draught = attributes["draught"]
      @grt = attributes["grt"]
      @dwt = attributes["dwt"]
      @year_built = attributes["year_built"]
    end

    def self.find(mmsi, extended = false, options = {})
      params = { mmsi: mmsi, timespan: 20 }.merge(options)
      params[:msgtype] = :extended if extended
      response = API.call(:exportvessel, params)
      result = response.xpath("//row")[0]

      if result != nil
        attributes = map_attributes(response.xpath("//row")[0], extended)
        new(attributes)
      end
    end

    def self.map_attributes(response, extended)
      attributes = {}
      attributes["mmsi"] = response['MMSI']
      attributes["lat"] = response['LAT'].to_f
      attributes["lon"] = response['LON'].to_f
      attributes["speed"] = response['SPEED'].to_i
      attributes["course"] = response['COURSE'].to_i
      if extended
        attributes["timestamp"] = response['TIMESTAMP']
        attributes["ship_name"] = response['SHIPNAME']
        attributes["ship_type"] = response['SHIPTYPE'].to_i
        attributes["imo"] = response['IMO']
        attributes["callsign"] = response['CALLSIGN']
        attributes["flag"] = response['FLAG']
        attributes["current_port"] = response['CURRENT_PORT']
        attributes["last_port"] = response['LAST_PORT']
        attributes["last_port_time"] = response['LAST_PORT_TIME']
        attributes["destination"] = response['DESTINATION']
        attributes["eta"] = response['ETA']
        attributes["length"] = response['LENGTH'].to_i
        attributes["width"] = response['WIDTH'].to_i
        attributes["draught"] = response['DRAUGHT'].to_i
        attributes["grt"] = response['GRT'].to_i
        attributes["dwt"] = response['DWT'].to_i
        attributes["year_built"] = response['YEAR_BUILT'].to_i
      else
        attributes["status"] = response['STATUS'].to_i
        attributes["timestamp"] = response['TIMESTAMP']
      end
      attributes
    end

    # http://help.marinetraffic.com/hc/en-us/articles/203990998-What-is-the-significance-of-the-AIS-Navigational-Status-Values-
    def status_human
      case status
        when  0
          'under way using engine'
        when  1
          'at anchor'
        when  2
          'not under command '
        when  3
          'restricted maneuverability'
        when  4
          'constrained by her draught'
        when  5
          'moored'
        when  6
          'aground '
        when  7
          'engaged in fishing'
        when  8
          'under way sailing'
        when  9
          'reserved for future amendment of navigational status for ships carrying DG, HS, or MP, or IMO hazard or pollutant category C, high-speed craft (HSC)'
        when 10
          'reserved for future amendment of navigational status for ships carrying dangerous goods (DG), harmful substances (HS) or marine pollutants (MP), or IMO hazard or pollutant category A, wing in ground (WIG)'
        when 11
          'power-driven vessel towing astern (regional use)'
        when 12
          'power-driven vessel pushing ahead or towing alongside (regional use)'
        when 13
          'reserved for future use'
        when 14
          'AIS-SART (active), MOB-AIS, EPIRB-AIS'
        when 15
          'undefined = default (also used by AIS-SART, MOB-AIS and EPIRB-AIS under test)'
        end
      end

    # http://help.marinetraffic.com/hc/en-us/articles/205579997-What-is-the-significance-of-the-AIS-SHIPTYPE-number-
    def ship_type_human
      return if ship_type == nil
      case ship_type.to_s[0].to_i
      when 1
        'Reserved'
      when 2
        'Wing In Ground'
      when 3
        'Special Category'
      when 4
        'High-Speed Craft'
      when 5
        'Special Category'
      when 6
        'Passenger'
      when 7
        'Cargo'
      when 8
        'Tanker'
      when 9
        'Other'
      end
    end
  end
end
