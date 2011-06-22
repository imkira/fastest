module Fastest
  module Platform
    # @return [Unix, Mac, Windows]
    # Singleton instance of the current platform
    def self.instance
      Platform.family.instance
    end

    # @return [Class]
    # The concrete platform class of the current platform.
    def self.family
      @family ||=
        begin
          description = RUBY_PLATFORM
          case description.downcase
          when /darwin/
            Mac
          when /linux|freebsd|openbsd|netbsd/
            Unix
          when /mswin/
            Windows
          else
            raise UnknownPlatformError, "Unknown platform: #{description}"
          end
        end
    end

    # @return [true, false] true on Unix (including MacOS), false otherwise
    def unix?
      kind_of? Unix
    end

    # @return [true, false] true on MacOS, false otherwise
    def mac?
      kind_of? Mac
    end

    # @return [true, false] true on Windows, false otherwise
    def windows?
      kind_of? Windows
    end
  end
end
