# -*- coding: utf-8 -*-
require 'optparse'
require 'ostruct'
require 'socket'

module SimpleServer
  class ConfigurationAssignedTwice < StandardError
  end

  module ArgumentParser
    @@config = OpenStruct.new
    @@set = []

    def self.config
      @@config
    end

    def config
      @@config
    end

    def self.parse(args)
      @@config.interface = Addrinfo.ip('0.0.0.0')
      get_parser.parse!(args)
      throw "Port jest wymagany" unless @@set.include?(:port)
    end

    def self.clean
      @@set = []
    end

    def self.get_parser()
      OptionParser.new() do |opt|
        opt.banner = "Prosty serwer"

        opt.on("-p","--port [port]","Port serwera") do |port|
          raise ConfigurationAssignedTwice if @@set.include?(:port)
          config.port = Integer(port)
          if(config.port < 0)
            raise ArgumentError
          end
          @@set << :port
        end

        opt.on("-i","--interface [interface]") do |interface|
          config.interface = Addrinfo.ip(interface)
        end
      end
    end

    def self.dump
      "port #{@@config.port if @@config.port} interface #{@@config.interface.ip_address if @@config.interface}"
    end
  end
end
