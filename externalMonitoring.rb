require_relative './lib/httpResponse'
require_relative './lib/httpsResponse'
require_relative './lib/config'
require_relative './service/certificateService'
require_relative './service/notificationService'
require_relative './service/responseService'

class ExternalMonitoring
  def initialize()
    configs = Config.new
    @uri = configs.uri
    @urls = configs.urls
    @webhook_url = configs.webhook_url
  end

  def exec()
    basicMonitoring = HttpResponse.new(@urls)
    sslMonitoring = HttpsResponse.new(@uri)

    basic_check(basicMonitoring)
    ssl_check(sslMonitoring)
  end

  def basic_check(request) # TODO implements
    check_status(request.status_code)
    check_response_time(request.response_time)
  end

  def ssl_check(request) # TODO implements
    check_certificate_valid(request)
  end

  private
    def check_certificate_valid(request)
      if check(request)
        # TODO fix notification
        notify_slack(@webhook_url, 'certificate is vaild')
      else
        notify_slack(@webhook_url, 'certificate is not valid')
      end
    end
end
