
module SimpleServer
  class ClientHandler
    def initialize(socket)
      @socket = socket
    end

    def start
      set_signal_handlers
      fork do 
        loop do
          @socket.puts '>'
          first = @socket.recv(1)
        end
      end
    end

    def set_signal_handlers
      Signal.trap("TERM") do
        @socket.write "Server is going DOWN. NOW!\n"
        @socket.close unless @socket.closed?
        exit!(0)
      end
      Signal.trap("INT") do
        @socket.write "Server is going DOWN. NOW!\n"
        @socket.flush
        @socket.close unless @socket.closed?
        exit!(0)
      end
    end
  end
end
