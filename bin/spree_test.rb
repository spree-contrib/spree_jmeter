require 'bundler'

require_relative '../lib/spree_performance'
require_relative '../lib/spree_performance/tests/spree'

class SpreeTest < SpreePerformance::CLI

  no_commands do
    def test_plan
      SpreePerformance::Tests::Spree.new options
    end
  end

end

SpreeTest.start
