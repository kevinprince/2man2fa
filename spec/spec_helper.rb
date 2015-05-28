# spec/spec_helper.rb
require 'rack/test'
require 'rspec'
require 'database_cleaner'
require 'sms_spec'

require File.expand_path '../../app.rb', __FILE__

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end


DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.configure do |config|
  config.include(SmsSpec::Helpers)
  config.include(SmsSpec::Matchers)
  config.include RSpecMixin
end

SmsSpec.driver = 'twilio-ruby'
