# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'lastfm/version'
require 'date'

Gem::Specification.new do |s|
  s.required_ruby_version = ">= #{Lastfm::RUBY_VERSION}"
  s.authors = ['Rob Whittaker']
  s.date = Date.today.strftime('%Y-%m-%d')

  s.description = <<-HERE
lastfm is a Ruby gem for generating charts of tracks listened to by last.fm
users over a given time period. It is used to keep track of how much songs have
been listening to recently. Use lastfm if you're interested in what you've been
listening to over an "unusual" time period.
  HERE

  s.email = 'rob@purinkle.co.uk'
  s.executables = []
  s.extra_rdoc_files = %w[README.md LICENSE]
  s.files = `git ls-files`.split("\n")
  s.homepage = 'http://github.com/purinkle/lastfm'
  s.license = 'MIT'
  s.name = 'lastfm'
  s.rdoc_options = ['--charset=UTF-8']
  s.require_paths = ['lib']
  s.summary = "Generate a chart of top last.fm tracks for a given period"
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.version = Lastfm::VERSION

  s.add_dependency "dotenv"
  s.add_dependency "faraday"
  s.add_dependency "faraday_middleware"
  s.add_dependency 'rake'

  s.add_development_dependency 'rspec', '~> 3.2'
  s.add_development_dependency "rspec_junit_formatter"
  s.add_development_dependency "vcr"
  s.add_development_dependency "webmock"
end
