module Fastest
  module Unix
    class Process < Fastest::GenericProcess
      def self.run (command_line, options = {}) 
        ::Process.popen3(command_line)
      end
    end
  end
end
