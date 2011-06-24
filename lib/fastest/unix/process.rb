module Fastest
  module Unix
    # Process class for Unix-like platforms (see {GenericProcess})
    # @abstract
    class Process < Fastest::GenericProcess
      def self.run (command_line, options = {}) 
        ::Process.spawn(command_line)
      end
    end
  end
end
