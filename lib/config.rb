require 'yaml'

class Config
  def initialize
    @configs = YAML.load_file("./config/params.yml") # TODO Dynamic
  end

  def uri
    @configs["uri"]
  end

  def urls
    @configs["urls"]
  end

  def webhook_url
    @configs["webhook_url"]
  end

  def mackerel_host_id
    @configs["mackerel"]["host_id"]
  end

  def mackerel_api_key
    @configs["mackerel"]["api_key"]
  end
end
