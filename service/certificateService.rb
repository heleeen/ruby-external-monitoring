def check_expired(request)
  request.not_after > Time.now
end
