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

unless defined?(Fastest::Platform)
  namespace = Fastest::GenericPlatform.namespace
  Fastest::Platform = namespace::Platform.instance
  Fastest::Process = namespace::Process
end
