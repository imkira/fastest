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
  unless defined?(Fastest::Platform)
    Fastest::Platform = GenericPlatform.namespace::Platform.instance
  end
  unless defined?(Fastest::Process)
    Fastest::Process = GenericPlatform.namespace::Process
  end
end
