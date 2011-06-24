module Fastest
  # This module acts as a namespace for all Windows platform definitions
  module Windows
    # Platform class for Windows systems
    class Platform < GenericPlatform
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
