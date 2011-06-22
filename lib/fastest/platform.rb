module Fastest
  module Platform

    # @return [Linux, Mac, Windows]
    # Singleton instance of the current platform
    def self.instance
      Platform.os.instance
    end

    # @return [Class]
    # The concrete platform class of the current platform.
    def self.os
      description = RUBY_PLATFORM
      case description.downcase
      when /linux/
        Linux
      when /darwin/
        Mac
      when /mswin/
        Windows
      else
      raise UnknownPlatformError, "Unknown platform: #{description}"
      end
    end

    # @return [true, false] true on Linux, false otherwise
    def linux?
      kind_of? Linux
    end

    # @return [true, false] true on Mac OS, false otherwise
    def mac?
      kind_of? Mac
    end

    # @return [true, false] true on Windows, false otherwise
    def windows?
      kind_of? Windows
    end
  end
end
