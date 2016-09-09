require 'bundler/setup'

Bundler.require(:default, :test)

require (Pathname.new(__FILE__).dirname + '../lib/lastfm').expand_path

Dir['./spec/support/**/*.rb'].each { |file| require file }
