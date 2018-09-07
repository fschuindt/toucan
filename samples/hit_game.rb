require 'toucan'

class Hit10Game
  def initialize
    @hits = 0
  end

  def hit
    @hits += 1
  end

  def buff
    @hits -= 1
  end

  def win?
    @hits >= 10
  end
end

hit_game = Hit10Game.new
app = Toucan::Application.new

app.inputs do |input|
  if input == 'hit'
    hit_game.hit
    app.puts "Hit"
  else
    app.puts "Unknown command."
  end
end

app.outputs do
  if hit_game.win?
    app.clear
    app.puts "You win!"
    sleep 10
    break
  end

  app.puts "Buffing..."
  hit_game.buff

  sleep 2
end
