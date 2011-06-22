require 'singleton'

module Fastest
  module Windows
    class Platform
      include GenericPlatform
      include Singleton

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
