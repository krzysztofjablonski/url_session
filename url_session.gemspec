# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "url_session/version"

Gem::Specification.new do |s|
  s.name        = "url_session"
  s.version     = UrlSession::VERSION
  s.authors     = ["Krzysztof Jablonski"]
  s.email       = ["jablko@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Session id in url}
  s.description = %q{UrlSession stores your session in memcache (dalli), puts session_id to every url and parses it in midleware}

  s.rubyforge_project = "url_session"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "dalli", '>= 1.1.0'
  s.add_runtime_dependency "rails", '~> 3.2.0'
end
