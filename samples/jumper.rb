require 'toucan'

class Jumper
  attr_accessor :jump

  def initialize
    @jump = 1
  end

  def double
    @jump = @jump * 2
  end
end

app = Toucan::Application.new
jumper = Jumper.new

app.inputs do |input|
  next unless input.to_i > 0
  jumper.jump = input.to_i
  app.puts "Jumped to #{input}"
end

app.outputs_loop do
  jumper.double
  app.puts jumper.jump
  sleep 1
end
