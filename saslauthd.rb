require 'socket'

class SASLauth
def initialize(path); @path = path end
def authenticate(username, password, service = "imap", realm = "")
  a = [username.size, username,
       password.size, password,
       service.size, service,
       realm.size, realm ]
  s = a.pack("na*na*na*na*")
  UNIXSocket.open(@path) {|f| 
    f.write s
    if f.read.unpack("na*")[1] =~ /^OK/
      true
    else
      false
    end
  }
end
end
