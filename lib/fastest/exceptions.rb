module Fastest
  # This module acts as a namespace for all Exception classes
  module Exception
    # 'Unknown platform detected' exception class
    class UnknownPlatform < ::Exception; end
    # 'Unknown process state' exception class
    class UnknownProcessState < ::Exception; end
  end
end
