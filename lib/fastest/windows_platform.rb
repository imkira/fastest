require 'singleton'

module Fastest
  class Windows
    include Platform
    include Singleton

    def initialize
    end
  end
end
