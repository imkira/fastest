$:<<(File.join(File.dirname(__FILE__), '..', 'lib'))
$:<<(File.dirname(__FILE__))
require 'rspec'
require 'fastest'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  
end
