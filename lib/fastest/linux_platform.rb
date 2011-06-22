require 'singleton'

module Fastest
  class Linux
    include Platform
    include Singleton

    def initialize
    end
  end
end
