require 'singleton'

module Fastest
  class Mac
    include Platform
    include Singleton

    def initialize
    end
  end
end
