require 'socket'

module SimpleServer
  class Server
    def initialize(config)
      @addrinfo = Addrinfo.tcp(cofnig.interface.ip_address,config.port)
      @pids = []
      Signal.trap("TERM") do
        @pids.each do |pid|
          Process.kill("TERM",pid)
          Process.waitall
          exit(0)
        end
      end
      Signal.trap("INT") do
        @pids.each do |pid|
          Process.kill("INT",pid)
          Process.waitall
          exit(0)
        end
      end
    end


    def start
      begin
        @server = @addrinfo.bind
        @server.listen
        loop do
          socket,addrinfo = @server.accept
          begin
            @pid << fork do 
              begin
                
              ensure
                socket.close
              end
            end
            puts "Connection handle by process #@pid"
          ensure
            socket.close if socket
          end
        end
      ensure
        @server.close
      end
    end

    def clean_handled_client 

    end
  end
end
