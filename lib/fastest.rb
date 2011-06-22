require 'rubygems'
require 'bundler'
Bundler.require(:default)

module Fastest
end

$:<<(File.dirname(__FILE__))
require 'fastest/exceptions'
require 'fastest/platform'
require 'fastest/linux_platform'
require 'fastest/mac_platform'
require 'fastest/windows_platform'

