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

    exe_check_metrics(basicMonitoring, sslMonitoring)
  end

  private

    # TODO implements
    def exe_check_metrics(basicMonitoring, sslMonitoring)
      notify_slack(@webhook_url, 'status code is not valid') if !check_status(basicMonitoring.status_code)
      notify_slack(@webhook_url, 'responsetime is not valid') if !check_response_time(basicMonitoring.response_time)
      notify_slack(@webhook_url, 'certificate is not valid') if !check_expired(sslMonitoring)
    end

end
