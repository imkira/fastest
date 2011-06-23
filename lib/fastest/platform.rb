require 'singleton'

module Fastest
  class GenericPlatform
    include Singleton

    # @return [Module]
    # The concrete platform namespace for the current platform.
    def self.namespace
      @namespace ||=
        case RUBY_PLATFORM
        when /darwin/i
          require 'fastest/mac/platform'
          Fastest::Mac
        when /freebsd|openbsd|netbsd/i
          require 'fastest/bsd/platform'
          Fastest::BSD
        when /linux/i
          require 'fastest/linux/platform'
          Fastest::Linux
        when /mswin/i
          require 'fastest/windows/platform'
          Fastest::Windows
        else
          raise UnknownPlatformError, "Unknown platform: #{platform}"
        end
    end

    # @return [true, false] true on Unix (including MacOS), false otherwise
    def unix?
      kind_of? Unix::Platform rescue false
    end

    # @return [true, false] true on Linux, false otherwise
    def linux?
      kind_of? Unix::Platform rescue false
    end

    # @return [true, false] true on BSD (including MacOS), false otherwise
    def bsd?
      kind_of? BSD::Platform rescue false
    end

    # @return [true, false] true on MacOS, false otherwise
    def mac?
      kind_of? Mac::Platform rescue false
    end

    # @return [true, false] true on Windows, false otherwise
    def windows?
      kind_of? Windows::Platform rescue false
    end
  end
end
