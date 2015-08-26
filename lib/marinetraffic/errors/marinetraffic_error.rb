module Marinetraffic
  class MarinetrafficError < StandardError
    attr_reader :message
    attr_reader :error_code
    attr_reader :http_status
    attr_reader :http_body
    attr_reader :http_headers

    def initialize(message=nil, http_status=nil, http_body=nil, http_headers=nil, error_code=nil)
      @message = message
      @http_status = http_status
      @http_body = http_body
      @http_headers = http_headers || {}
      @error_code = error_code
    end

    def to_s
      code_string = @error_code.nil? ? "" : "(Error #{@error_code}) "
      "#{code_string}#{@message}"
    end
  end
end
