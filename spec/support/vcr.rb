# frozen_string_literal: true

require "vcr"

VCR.configure do |config|
  config.cassette_library_dir = "spec/support/vcr/cassettes"
  config.hook_into :webmock
end
