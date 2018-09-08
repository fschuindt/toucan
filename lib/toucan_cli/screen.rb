module ToucanCLI
  class Screen
    attr_accessor :iqueue, :iwin, :owin

    def initialize
      @iqueue = Queue.new
      Curses.init_screen
      Curses.crmode

      draw_output_window
      draw_input_window
      feed_iqueue
    end

    def start
      begin
        loop do
          yield
        end
      ensure
        @iwin.close if @iwin
        @owin.close if @owin

        Curses.close_screen
      end
    end

    private

    # Curses::Window.new(height, width, top, left)
    def draw_output_window
      @owin = Curses::Window.new((Curses.lines - 2), Curses.cols, 0, 0)
      @owin.setpos(0, 0)
      @owin.scrollok(true)
      @owin.setscrreg(0, (Curses.lines - 2))
      @owin.refresh
    end

    def draw_input_window
      @iwin = Curses::Window.new(1, Curses.cols, (Curses.lines - 1), 0)
      @iwin.setpos(1, 2)
      @iwin.scrollok(true)
    end

    def feed_iqueue
      Thread.new do
        loop do
          @iwin.refresh
          @iqueue << @iwin.getstr()
          @iwin.clear
        end
      end
    end
  end
end
