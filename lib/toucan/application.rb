module Toucan
  class Application
    def initialize
      @screen = Screen.new
    end

    def inputs
      Thread.new do
        loop do
          input = @screen.iqueue.pop
          next unless input

          yield(input)
          refresh
        end
      end
    end

    def outputs
      @screen.start do
        yield
      end
    end

    def outputs_loop
      @screen.start do
        loop do
          yield
        end
      end
    end

    def clear
      @screen.owin.clear
      refresh
    end

    def puts(string)
      @screen.owin.addstr("#{string}\n")
      refresh
    end

    # TODO
    def alert
    end

    def print(string)
      @screen.owin.addstr(string)
      refresh
    end

    private

    def refresh
      @screen.owin.refresh
      @screen.iwin.refresh
    end
  end
end
