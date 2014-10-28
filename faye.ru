require 'faye'
require File.expand_path('../config/initializers/faye_token.rb', __FILE__)
Faye::WebSocket.load_adapter('thin')

class ServerAuth
  def incoming(message, callback)
    if message['channel'] !~ %r{^/meta/}
      # if message['ext'] != FAYE_TOKEN
      #   message['error'] = '403::Password required'
      # end
    end
    callback.call(message)
  end

  def outgoing(message, callback)
    if message['ext']
      message['ext'] = {}
    end
    callback.call(message)
  end
end

faye_server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 45)
faye_server.add_extension(ServerAuth.new)
run faye_server
