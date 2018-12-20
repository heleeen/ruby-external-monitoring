require_relative '../service/mackerelService'

def check_status(status)
  return false if status != "200"
  true
end

def check_response_time(response_time)
  mackerel = MackerelService.new

  save_response_time(mackerel, response_time)
  return false if !check_latency(response_time)
  return false if !check_if_slower(mackerel, response_time)
  true
end

private
  def save_response_time(mackerel, response_time)
    mackerel.post_to_mackerel(response_time)
  end

  def check_latency(response_time)
    return false if response_time > 5.0
    true
  end

  def check_if_slower(mackerel, response_time)
    return false if response_time > mackerel.latest_response_time() + 1 # NaYaMu
    true
  end
