module Geetest
  module Version
    MAJOR = 0
    MINOR = 1
    PATCH = 6

    def self.to_s
      [MAJOR, MINOR, PATCH].join('.')
    end
  end # Version
end #Module Geetest
