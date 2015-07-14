# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'liveblink/version'

Gem::Specification.new do |spec|
  spec.name          = "liveblink"
  spec.version       = Liveblink::VERSION
  spec.authors       = ["Nicolas Oman"]
  spec.email         = ["nickomang@gmail.com"]

  spec.summary       = "A ruby CLI to make watching Twitch streams and VODs via Livestreamer fast and easy"
  spec.homepage      = "https://github.com/Nickomang/liveblink"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "http://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  # spec.bindir        = "exe"
  spec.executables   = "liveblink"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_dependency 'thor'
  spec.add_dependency 'httparty'
  spec.add_dependency 'cathodic', "~> 0"
  spec.add_dependency 'iconv'
end
