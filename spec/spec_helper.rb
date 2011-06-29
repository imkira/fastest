$:<<(File.join(File.dirname(__FILE__), '..', 'lib'))
$:<<(File.dirname(__FILE__))

require 'rubygems'
require 'bundler'
Bundler.require(:development)
require 'fastest'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir['support/**/*.rb'].each do |f|
  require f
end

Factory.find_definitions

RSpec.configure do |config|
  
end
