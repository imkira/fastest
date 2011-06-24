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
    end
  end
end
