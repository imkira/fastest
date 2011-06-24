require 'fastest/unix/process'

module Fastest
  # This module acts as a namespace for all Unix-like platform definitions
  module Unix
    # Platform class for Unix-like systems
    # @abstract
    class Platform < GenericPlatform
    end
  end
end
