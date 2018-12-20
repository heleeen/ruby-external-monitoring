require "benchmark"
require 'net/http'
require 'uri'

class HttpResponse
  def initialize(host)
    uri = URI.parse(host)
    @response_time = Benchmark.realtime do
      @response = Net::HTTP.get_response(uri)
    end
  end

  def status_code
    @response.code
  end

  def response_time
    @response_time
  end
end
