lib = File.expand_path("../lib", __FILE__)
$:.unshift(lib) unless $:.include?(lib)

require "dripl/version"

Gem::Specification.new do |s|
  s.name        = "dripl"
  s.version     = Dripl::VERSION
  s.authors     = ["Ruby Druid Community"]
  s.summary     = %q{An interactive terminal for Druid}
  s.description = <<-EOF
    dripl is an interactive terminal for Druid. It allows
    fetching metadata and constructing and sending queries
    to a Druid cluster.
  EOF
  s.homepage    = "https://github.com/ruby-druid/dripl"
  s.license     = "MIT"

  s.files = Dir["lib/**/*"] + %w{LICENSE README.md dripl.gemspec}
  s.test_files = Dir["spec/**/*"]
  s.require_paths = ["lib"]
  s.executables = ["dripl"]

  s.add_runtime_dependency "awesome_print", "~> 1.6"
  s.add_runtime_dependency "mixlib-cli", "~> 1.6"
  s.add_runtime_dependency "ruby-druid", "~> 0.9"
  s.add_runtime_dependency "ripl", "~> 0.7"
  s.add_runtime_dependency "terminal-table", "~> 1.5"
end
