require 'yaml'
require 'ostruct'

module Claws
  class ConfigurationError < StandardError; end

  class Configuration
    attr_accessor :path, :capistrano, :aws, :ec2

    def initialize(use_path = nil)
      self.path = use_path || File.join(ENV['HOME'], '.claws.yml')

      begin
        yaml = YAML.load_file(path)
      rescue Exception
        raise ConfigurationError, "Unable to locate configuration file: #{self.path}"
      end

      self.capistrano = OpenStruct.new( yaml['capistrano'] )
      self.aws = yaml['aws']
      self.ec2 = OpenStruct.new( { :fields => yaml['ec2']['fields'] })
    end
  end
end
