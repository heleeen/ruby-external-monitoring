require 'json'
require 'net/http'
require 'uri'

def notify_slack(webhook_url, message)
  uri  = URI.parse(webhook_url) # SHOULD read config
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  messages = { attachments: [{ color: "danger", fields: [{ title: "ExternalMonitoring", value: message}] }] }.to_json

  http.start do
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(payload: messages)
    http.request(request)
  end
end
