module ToucanCLI
  LIB_PATH = File.expand_path('../../', __FILE__)

  class Configuration
    attr_accessor :foo

    def initialize
      @foo = :bar
    end
  end
end
