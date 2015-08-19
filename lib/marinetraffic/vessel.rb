module Marinetraffic
  class Vessel

    attr_reader :mmsi, :lat, :lon, :speed, :course, :status, :timestamp
    attr_reader :ship_type, :ship_name, :imo, :callsign, :flag, :current_port, :last_port, :last_port_time, :destination, :eta, :length, :draught, :grt, :dwt, :year_built

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
      @draught = attributes["draught"]
      @grt = attributes["grt"]
      @dwt = attributes["dwt"]
      @year_built = attributes["year_built"]
    end

    def self.find(mmsi, extended = false)
      params = { mmsi: mmsi, timespan: 20 }
      params[:msgtype] = :extended if extended
      response = API.call(:exportvessel, params)
      list = JSON.parse(response.body).first
      attributes = map_attributes(list)
      new(attributes)
    end

    def self.map_attributes(list)
      attributes = {}
      attributes["mmsi"] = list.shift
      attributes["lat"] = list.shift
      attributes["lon"] = list.shift
      attributes["speed"] = list.shift
      attributes["course"] = list.shift
      attributes["status"] = list.shift
      attributes["timestamp"] = list.shift
      attributes["ship_type"] = list.shift
      attributes["ship_name"] = list.shift
      attributes["imo"] = list.shift
      attributes["callsign"] = list.shift
      attributes["flag"] = list.shift
      attributes["current_port"] = list.shift
      attributes["last_port"] = list.shift
      attributes["last_port_time"] = list.shift
      attributes["destination"] = list.shift
      attributes["eta"] = list.shift
      attributes["length"] = list.shift
      attributes["draught"] = list.shift
      attributes["grt"] = list.shift
      attributes["dwt"] = list.shift
      attributes["year_built"] = list.shift
      attributes
    end
  end
end