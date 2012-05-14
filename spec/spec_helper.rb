require File.expand_path('../../lib/rbox', __FILE__)

require 'minitest/autorun'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures'
  config.default_cassette_options = { :record => :once }
  config.hook_into :faraday
end