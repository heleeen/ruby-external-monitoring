require 'socket'
require 'openssl'

class Request
  def initialize(host)
    TCPSocket.open(host, 443) do |socket|
      ssl_socket = OpenSSL::SSL::SSLSocket.new(socket)
      ssl_socket.hostname = host
      ssl_socket.connect
      @certificate = ssl_socket.peer_cert
      ssl_socket.close
    end
  end

  def not_after
    @certificate.not_after
  end

end
