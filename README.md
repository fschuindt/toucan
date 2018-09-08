# ![toucan](https://github.com/fschuindt/toucan/raw/master/images/toucan_small.png?raw=true) Ruby Toucan CLI
*A Ruby framework to craft small yet amazing CLI applications.  
Powered by [Curses](https://github.com/ruby/curses).*

**I'm still writing this document as well as this software, don't use it just yet!**

Any kind of contribution is welcome!

## Motivations
If you are like me and enjoys terminal applications, and also like to write them every once in a while especially to tackle small necessities in life (and you may also like the simplicity of Ruby), you probably have already faced its well equipped set of limitations. One of the most commons next steps is to look into solutions like [ncurses](https://www.gnu.org/software/ncurses/), but it often sounds like using a cannon to kill a ant and it don't comes without a small (but existent) learning curve. And a dozen other implications.

Personally, I find the synchronous IO the most annoying limitation of common CLIs. If you need user input during runtime, you may lock your execution waiting for it. You can wait in a parallel thread, but if you need to print out stuff while waiting you will find yourself in a hairy situation.

And last but not least, ASCII animations. Try to grab any ASCII art and make it "walk" across the screen. Your terminal will be filled with older frames and that sucks. To clear a terminal window all you do is print out a bunch of `\n` characters, which is far from being practical.

Toucan CLI tries to present a quick solution for those two problems.

## Introduction

Toucan provides a simple Curses layout that may serve a wide range of applications. There are only two windows: The **Input Window** and the **Output Window**. And you don't need to know anything about Curses, Toucan will take care.

![toucan layout](https://github.com/fschuindt/toucan/raw/master/images/ToucanLayout.png?raw=true)

The input window is controlled by a parallel thread which has its queue filled with user's inputs. So a user can type and send input anytime he wants, regardless of what your application is doing. Everytime he types something, you decide what to do with it.

The output window is your application per-say. It runs into the main thread and you can do whatever you want here, regardless if the user is typing anything.

Here is the basic shape for a Toucan CLI application:
```ruby
require 'toucan_cli'

app = ToucanCLI::Application.new

app.inputs do |input|
  # Deals with input here.
end

app.outputs do
  # Do stuff here.
end
```

Let's try to see some action. Consider the following Ruby class:
```ruby
class Jumper
  attr_accessor :jump

  def initialize
    @jump = 1
  end

  def double
    @jump = @jump * 2
  end
end
```

So, when initialized it sets `@jump = 1`. When the method `:double` is called, it doubles the value on `@jump`. Cool.

Let's use it in our first Toucan program:
```ruby
require 'toucan_cli'

app = ToucanCLI::Application.new
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
```

### The outputs block

First, check the block on `app.outputs_loop`. It:
- Calls the method `:double` on the `jumper` object.
- Prints out the `jumper.jump` value.
- Waits 1 second.

Notice it's a `outputs_loop`. So this block runs in a loop. Alternatively `outputs` can be used to execute just once.

And this is your application. Every second, you double the number and prints it out. Great.

### The inputs block

But wait. There's the input window and the block on `app.inputs`. It's running in parallel, it will receive everything the user type into the input window. And it:
- Will check if the user typed a valid number greater than zero.
- If so, it will set the user typed value as the new `jumper.jump` value.
- And will print out a notice about the value being changed.

Different from the output block, this one will always run as a loop.

### Running it

Let's run this code:

**GIF**  
![toucan demo](https://github.com/fschuindt/toucan/raw/master/images/toucan_demo.gif?raw=true)

**Asciinema**  
[![asciicast](https://asciinema.org/a/200240.png)](https://asciinema.org/a/200240)

### Conclusion

Toucan abstracts all your input logic and provides you pure gold Curses sugar in the meantime. Non-blocking your code and allowing great features to be implemented.

## Installation

**WARNING**

As this gem is facing its early days of life, I recommend you to not use it for any production environment just yet. I've published the version `0.0.1` to RubyGems.org, but I want you to mind some things:
- Any `0.0.X` version is experimental. Things can be changed without changing the version tag itself.
- Until the release of the version `0.1.0`, is better to clone this repository and build the gem by yourself.
- As being experimental, many stuff can go wrong. I haven't faced any relevant issue so far, but if you do/did, please let me know by opening a GitHub issue.

### Building the gem by yourself (Recommended)
First, clone this repository and get inside of it:
```
$ git clone https://github.com/fschuindt/toucan.git && cd toucan
```

Build the Gem:
```
$ gem build toucan.gemspec
```

And install it:
```
$ gem install toucan_cli-0.0.1.gem
```

Now you shall be able to use it in your Ruby programs by doing:
```ruby
require 'toucan_cli'
```

### Using bundler (Not the best option for now)
You can either enter in your terminal:
```
$ gem install toucan
```

Or, in your `Gemfile`:
```
gem 'toucan_cli', '~> 0.0.1'
```
*Then following by `$ bundle install`*

So, again, you can just:
```ruby
require 'toucan_cli'
```

And it may work.

## Basic Usage

TODO

## To Do
- [ ] Readme
- [ ] Tests
- [ ] Fix endwin bug (app still works great)
- [ ] Documentation
- [ ] Refactor
- [ ] Publish Gem
- [ ] CI

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

*The Toucan logo was made using a [royalty-free image](https://svgsilh.com/image/1293815.html).*

## Code of Conduct

Everyone interacting in the Toucan project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/toucan/blob/master/CODE_OF_CONDUCT.md).
