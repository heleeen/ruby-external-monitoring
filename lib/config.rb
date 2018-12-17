require 'yaml'

class Config
  def initialize
    @configs = YAML.load_file("./config/params.yml") # TODO Dynamic
  end

  def urls
    @configs["urls"]
  end

  def webhook_url
    @configs["webhook_url"]
  end
end
