require 'bundler'

require_relative '../lib/spree_performance'
require_relative '../lib/spree_performance/tests/example'

class ExampleTest < SpreePerformance::CLI

  no_commands do
    def test_plan
      SpreePerformance::Tests::Example.new options
    end
  end

end

ExampleTest.start
