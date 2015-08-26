require "marinetraffic/version"
require "marinetraffic/vessel"
require "marinetraffic/api"

module Marinetraffic
  @api_base = 'http://services.marinetraffic.com/api'

  class << self
    attr_accessor :api_key, :api_base
  end
end
