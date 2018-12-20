require_relative '../service/mackerelService'

def check_status(status)
  return false if status != "200"
  true
end

def check_response_time(response_time)
  mackerel = MackerelService.new

  save_response_time(mackerel, response_time)
  check_latency(response_time)
  check_if_slower(mackerel, response_time)
end

private
  def save_response_time(mackerel, response_time)
    mackerel.post_to_mackerel(response_time)
  end

  def check_latency(response_time)
    false if response_time > 5.0
  end
