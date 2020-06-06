
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "toucan_cli/version"

Gem::Specification.new do |spec|
  spec.name          = "toucan_cli"
  spec.version       = ToucanCLI::VERSION
  spec.authors       = ["Fernando Schuindt"]
  spec.email         = ["f.schuindtcs@gmail.com"]

  spec.summary       = "A Ruby framework to craft small yet amazing CLI applications."
  # spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/fschuindt/toucan"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  # spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
  #   `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  # end

  spec.files = [
    'lib/toucan_cli.rb',
    'lib/toucan_cli/application.rb',
    'lib/toucan_cli/configuration.rb',
    'lib/toucan_cli/screen.rb',
    'lib/toucan_cli/version.rb'
  ]

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "curses", "~> 1.2"
end
