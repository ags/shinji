require "rspec"

$LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__), "..", "lib"))

require 'rails'
require 'shinji'

RSpec.configure do |config|
  config.order = 'random'
end

class TestLogger
  def error(error)
    p error
  end
end
