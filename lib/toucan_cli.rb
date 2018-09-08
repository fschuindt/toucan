require 'curses'
require 'thread'

require 'toucan_cli/application'
require 'toucan_cli/configuration'
require 'toucan_cli/screen'
require 'toucan_cli/version'

module ToucanCLI
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield configuration
  end
end
