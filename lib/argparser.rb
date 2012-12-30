# -*- coding: utf-8 -*-
require 'optparse'
require 'ostruct'
require 'socket'

module SimpleServer::ArgumentParser
  class ConfigurationError < StandardError

  end

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
    raise ConfigurationError.new("Port is require option") unless @@set.include?(:port)
    @@config
  end

  def self.clean
    @@set = []
  end

  def self.get_parser()
    OptionParser.new() do |opt|
      opt.banner = "Prosty serwer"

      opt.on("-p","--port [port]","Port serwera") do |port|
        raise ConfigurationError if @@set.include?(:port)
        config.port = Integer(port)
        if(config.port < 0)
          raise ArgumentError
        end
        @@set << :port
      end

      opt.on("-i","--interface [interface]") do |interface|
        begin
          Addrinfo.ip(interface)
          config.interface = interface
        rescue SocketError
          raise ConfigurationError.new("Interface is not valid")
        end
      end
    end
  end

  def self.dump
    "port #{@@config.port} interface #{@@config.interface}"
  end
end
