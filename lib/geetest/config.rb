require 'tmpdir'

module Geetest
  module Config
    class << self
      DEFAULT_OPTIONS = {
          :get_uri        => 'http://api.geetest.com/get.php',
          :valid_uri      => 'http://api.geetest.com/validate.php',
          :id             => nil,
          :key            => nil
      }

      REQUIRED_OPTION_KEYS = [:get_uri, :valid_uri, :id, :key]

      attr_reader :settings

      def load(config_file)
        if File.exists?(config_file)
          config_options = YAML.load_file(config_file)
          config_options.symbolize_keys!
          initialize_connect(config_options)
        end
      end

      def initialize_connect(options = {})
        @settings = DEFAULT_OPTIONS.merge!(options)
        REQUIRED_OPTION_KEYS.each do |opt|
          raise MissingArgsError, [opt] unless @settings.has_key?(opt)
        end
      end
    end
  end
end