require 'net/https'
require 'json'
require_relative '../lib/config'

class MackerelService
  def initialize
    configs = Config.new
    @host_id = configs.mackerel_host_id
    @mackerel_api_key = configs.mackerel_api_key
  end

  def post_to_mackerel(response_time)
    uri = URI.parse('https://mackerel.io/api/v0/tsdb')
    http = Net::HTTP.new(uri.host, 443)
    http.use_ssl = true

    req = Net::HTTP::Post.new(uri.path)
    req["X-Api-Key"] = @mackerel_api_key
    req["Content-Type"] = "application/json"
    req.body = [{ hostId: @host_id, name: "custom.response.time", value: response_time, time: Time.now.to_i }].to_json
    res = http.request(req)
  end
end
