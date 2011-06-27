require 'singleton'

module Fastest
  # Generic Platform class.
  # @abstract
  class GenericPlatform
    include Singleton

    # Returns the namespace (Module) under which the concrete
    # implementations for the current platform can be found.
    #
    # @return [Module] the platform namespace for the current platform
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
          raise Exception::UnknownPlatform, "Unknown platform: #{platform}"
        end
    end

    # Checks whether the platform refers to a Unix-like system
    # @return [true, false] true on Unix (including MacOS), false otherwise
    def unix?
      kind_of? Unix::Platform rescue false
    end

    # Checks whether the platform refers to a Linux system
    # @return [true, false] true on Linux, false otherwise
    def linux?
      kind_of? Unix::Platform rescue false
    end

    # Checks whether the platform refers to a BSD-like system
    # @return [true, false] true on BSD (including MacOS), false otherwise
    def bsd?
      kind_of? BSD::Platform rescue false
    end

    # Checks whether the platform refers to a MacOS system
    # @return [true, false] true on MacOS, false otherwise
    def mac?
      kind_of? Mac::Platform rescue false
    end

    # Checks whether the platform refers to a Windows system
    # @return [true, false] true on Windows, false otherwise
    def windows?
      kind_of? Windows::Platform rescue false
    end

    # Returns the time the system was last booted
    # @return [Time] the time the system was last booted
    def system_boot_time
      # time may vary slightly (usually by 1s difference) from call to call
      # so we memoize the value so it does not appear to vary
      @system_boot_time ||= (Sys::Uptime.boot_time).freeze
    end
  end
end
