require 'fastest/unix/platform'
require 'fastest/linux/process'

module Fastest
  # This module acts as a namespace for all Linux platform definitions
  module Linux
    # Platform class for Linux systems
    class Platform < Fastest::Unix::Platform
      # @return [String] path to default browser application
      def default_browser
        `update-alternatives --list x-www-browser`.lines.first.chomp
      end

      # @return [String] path to default (graphical) text editor
      def default_text_editor
        `update-alternatives --list gnome-text-editor`.lines.first.chomp
      end

      # Returns the HZ
      # @return [Fixnum] clock tick for the current kernel
      def system_clock_tick
        @@system_clock_tick ||= LibC::sysconf(LibC::SC_CLK_TCK)
      end
    end

    module LibC
      extend FFI::Library
      ffi_lib FFI::Library::LIBC
      attach_function :sysconf, [:int], :long

      SC_CLK_TCK = 2
    end
  end
end
