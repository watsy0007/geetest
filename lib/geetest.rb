require 'digest'
require 'net/http'

module Geetest
  autoload :Version, 'geetest/version'
  autoload :Config, 'geetest/config'
  class << self
    def establish_connection!(opts = {})
      Config.initialize_connect(opts)
    end

    def code
      "#{Config.settings[:get_uri]}?gt=#{Config.settings[:id]}"
    end

    def validate(challenge = '', validate = '', sec_code = '')
      if validate == Digest::MD5.hexdigest(Config.settings[:key], + 'geetest' + challenge)
        back = post(Config.settings[:valid_uri], seccode: sec_code) rescue ''
        return back == Digest::MD5.hexdigest(sec_code)
      end
      false
    end

    private

    def post(uri, data)
      uri = URI(uri)
      res = Net::HTTP.post_form(uri, data)
      res.body
    end
  end
end
