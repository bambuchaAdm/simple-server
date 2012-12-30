require 'spec_helper'

require 'ostruct'

module SimpleServer
  describe Server do
    before :all do
      @config = ArgumentParser.parse(["-p","1500","-i","127.0.20.2"])
    end
  end
end
