def check(request)
  request.not_after > Time.now
end
