# frozen_string_literal: true

require "bundler/setup"

require "base64"
require "vcr"

require "simplecov"
require "coveralls"
SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
  add_filter "/spec"
end
Coveralls.wear!

require "ukemi"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def authorization_field(username, password)
  token = "#{username}:#{password}"
  "Basic #{Base64.strict_encode64(token)}"
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.configure_rspec_metadata!
  config.hook_into :webmock
  config.ignore_localhost = false

  api_keys = %w(VIRUSTOTAL_API_KEY SECURITYTRAILS_API_KEY DNSDB_API_KEY)
  api_keys.each do |key|
    ENV[key] = "foo bar" unless ENV.key?(key)
    config.filter_sensitive_data("<#{key}>") { ENV[key] }
  end

  # CIRCL
  config.filter_sensitive_data("<CIRCL_AUTH>") {
    authorization_field ENV["CIRCL_PASSIVE_USERNAME"] || "foo", ENV["CIRCL_PASSIVE_PASSWORD"] || "bar"
  }
  # PassiveTotal
  config.filter_sensitive_data("<PASSIVETOTAL_AUTH>") {
    authorization_field ENV["PASSIVETOTAL_USERNAME"] || "foo", ENV["PASSIVETOTAL_API_KEY"] || "bar"
  }
end
