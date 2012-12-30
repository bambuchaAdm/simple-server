require 'spec_helper'

require 'socket'

module SimpleServer
  describe ClientHandler do

    let(:pair){ UNIXSocket.pair() }
    let(:remote){ pair[1] }
    let(:server){ pair[0] }
    let(:handler){ ClientHandler.new(server) }
    after :each do
      remote.close
      server.close
    end

    it "send message on get INT singal" do
      pid = handler.start
      Process.kill("INT",pid)
      remote.recv(30).should =~ /Server is going DOWN. NOW!/
      Process.wait
    end

    it "send message on get TERM signal" do
      pid = handler.start
      Process.kill("TERM",pid)
      remote.recv(30).should =~ /Server is going DOWN. NOW!/
      Process.wait
    end

    it "send prompt when redy" do
      pid = handler.start
      ans = remote.recv(10)
      ans.should start_with('>')
      Process.kill("TERM",pid)
    end
  end
end
