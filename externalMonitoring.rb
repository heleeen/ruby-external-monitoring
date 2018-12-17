require_relative './lib/request'
require_relative './lib/config'
require_relative './service/certificateService'
require_relative './service/notificationService'

class ExternalMonitoring
  def initialize()
    configs = Config.new
    @urls = configs.urls
    @webhook_url = configs.webhook_url
  end

  def exec()
    request = Request.new(@urls)

    check_url(request)
  end

  def check_url(request) # TODO implements
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
