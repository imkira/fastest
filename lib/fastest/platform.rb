module Fastest
  module Platform
    def self.instance
      Platform.os.instance
    end

    def self.os
      description = RUBY_PLATFORM
      case description.downcase
      when /linux/
        Linux
      when /darwin/
        Mac
      when /mswin/
        Windows
      end
    end

    def linux?
      kind_of? Linux
    end

    def mac?
      kind_of? Mac
    end

    def windows?
      kind_of? Windows
    end
  end
end
