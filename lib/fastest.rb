require 'rubygems'
require 'bundler'
Bundler.require(:default)

module Fastest
end

$:<<(File.dirname(__FILE__))
require 'fastest/exceptions'
require 'fastest/platform'
require 'fastest/process'
require 'fastest/window'
require 'fastest/unix/platform'
require 'fastest/mac/platform'
require 'fastest/windows/platform'

module Fastest
  if not defined?(Platform)
    Platform = GenericPlatform.namespace::Platform.instance
  end
end
