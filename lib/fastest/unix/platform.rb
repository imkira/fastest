require 'singleton'

module Fastest
  class Unix
    include Platform
    include Singleton

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
