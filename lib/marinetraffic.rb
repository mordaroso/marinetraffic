require "marinetraffic/version"
require "marinetraffic/vessel"
require "marinetraffic/api"

module Marinetraffic
  class << self
    attr_accessor :api_key
  end
end
