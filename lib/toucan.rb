require 'curses'
require 'thread'

require 'toucan/application'
require 'toucan/configuration'
require 'toucan/screen'
require 'toucan/version'

module Toucan
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
