require 'socket'

class SASLauth
  Version="0.1"
  def initialize(path = "/var/run/saslauthd/mux"); @path = path end
  def authenticate(username, password, service = "imap", realm = "")
    a = [username.size, username, password.size, password, service.size, service, realm.size, realm]
    s = a.pack("na*na*na*na*")
    UNIXSocket.open(@path) {|f| 
      f.write s
      f.read.unpack("na*")[1] =~ /^OK/ ? true : false
    }
  end
end
