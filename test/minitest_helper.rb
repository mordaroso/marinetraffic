$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'marinetraffic'
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'

env_file = 'test/fixtures/env.yml'
YAML.load(File.open(env_file)).each do |key, value|
  ENV[key.to_s] = value
end if File.exists?(env_file)

Marinetraffic.api_key = ENV['API_KEY']

VCR.configure do |c|
  c.cassette_library_dir = "test/fixtures"
  c.hook_into :webmock
  c.filter_sensitive_data('<APIKEY>') { Marinetraffic.api_key }
  c.filter_sensitive_data('<SUBSCRIPTIONKEY>') { ENV['SUBSCRIPTION_KEY'] }
end
