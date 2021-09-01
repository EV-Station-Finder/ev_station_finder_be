# frozen_string_literal: true

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.filter_sensitive_data('<MAPS_KEY>') { ENV['MAPS_KEY'] }
  config.filter_sensitive_data('<WEATHER_KEY>') { ENV['WEATHER_KEY'] }
  config.filter_sensitive_data('<CHARGER_KEY>') { ENV['CHARGER_KEY'] }
  config.configure_rspec_metadata!
  config.default_cassette_options = { re_record_interval: 7.days }
  config.allow_http_connections_when_no_cassette = true
end

#:allow_playback_repeats => true
