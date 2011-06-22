require 'rubygems'
require 'bundler'
Bundler.require(:default)

module Fastest
end

$:<<(File.dirname(__FILE__))
require 'fastest/platform.rb'
require 'fastest/linux_platform.rb'
require 'fastest/mac_platform.rb'
require 'fastest/windows_platform.rb'

