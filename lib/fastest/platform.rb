module Fastest
  module GenericPlatform
    # @return [Module]
    # The concrete platform namespace for the current platform.
    def self.namespace
      @description =
        begin
          description = RUBY_PLATFORM
          case description.downcase
          when /darwin/
            Fastest::Mac
          when /linux|freebsd|openbsd|netbsd/
            Fastest::Unix
          when /mswin/
            Fastest::Windows
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

