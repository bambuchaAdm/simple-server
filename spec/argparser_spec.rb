require 'spec_helper'

module SimpleServer
  describe ArgumentParser do
    let(:output){ArgumentParser.get_parser.to_s}

    before :each do 
      ArgumentParser.clean
    end

    it "has option for port" do
      output.should =~ /-p/
    end

    it "has shortcut for port option" do 
      output.should =~ /--port/
    end

    it "raise an exception on negative port" do 
      expect do 
        ArgumentParser.parse(["--port=-1200"])
      end.to raise_error(ArgumentError)
    end

    it "has option for interface" do
      output.should =~ /-i/
    end

    it "has shortcut for interface option" do
      output.should =~ /--interface/
    end

    it "raise error if we try override arguements" do 
      ArgumentParser.parse(["--port","1200"])
      ArgumentParser.config.port.should == 1200
      expect{ArgumentParser.parse(["--port","2200"])}.to raise_error ConfigurationAssignedTwice
    end
  end
end
