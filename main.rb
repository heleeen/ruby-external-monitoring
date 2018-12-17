require_relative './externalMonitoring'

def lambda_handler(event:, context:)
    monitoring = ExternalMonitoring.new
    monitoring.exec()
end
