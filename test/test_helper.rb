$: << File.join(File.dirname(__FILE__), 'lib')

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/spec'

require 'puppetry/test'
require 'puppetry'
