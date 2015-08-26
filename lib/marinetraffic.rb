require "marinetraffic/version"
require "marinetraffic/vessel"
require "marinetraffic/api"

require "marinetraffic/errors/marinetraffic_error"
require "marinetraffic/errors/authentication_error"
require "marinetraffic/errors/api_error"

module Marinetraffic
  @api_base = 'http://services.marinetraffic.com/api'

  class << self
    attr_accessor :api_key, :api_base
  end
end
