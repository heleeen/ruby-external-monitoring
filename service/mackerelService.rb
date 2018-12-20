require 'net/https'
require 'uri'
require 'json'
require_relative '../lib/config'

class MackerelService
  METRIC_NAME = "custom.response.time"

  def initialize
    configs = Config.new
    @host_id = configs.mackerel_host_id
    @mackerel_api_key = configs.mackerel_api_key
  end

  def post_to_mackerel(response_time)
    uri = URI.parse('https://mackerel.io/api/v0/tsdb')
    http = Net::HTTP.new(uri.host, 443)
    http.use_ssl = true

    post = Net::HTTP::Post.new(uri.path)
    post["X-Api-Key"] = @mackerel_api_key
    post["Content-Type"] = "application/json"
    post.body = [{ hostId: @host_id, name: METRIC_NAME, value: response_time, time: Time.now.to_i }].to_json
    res = http.request(post)
  end

  def latest_response_time()
    uri = URI.parse('https://mackerel.io/api/v0/tsdb/latest?name=custom.response.time&hostId=' + @host_id)
    http = Net::HTTP.new(uri.host, 443)
    http.use_ssl = true

    post = Net::HTTP::Get.new(uri)
    post["X-Api-Key"] = @mackerel_api_key
    response = http.request(post).body
    response_json = JSON.parse(response)
    response_json["tsdbLatest"][@host_id][METRIC_NAME]["value"]
  end
end
