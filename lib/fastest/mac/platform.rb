require 'fastest/bsd/platform'

module Fastest
  # This module acts as a namespace for all MacOS platform definitions
  module Mac
    # Platform class for MacOS systems
    class Platform < Fastest::BSD::Platform
      # @return [String] path to default browser application
      def default_browser
        raise 'not implemented'
      end

      # @return [String] path to default (graphical) text editor
      def default_text_editor
        raise 'not implemented'
      end
    end
  end
end
