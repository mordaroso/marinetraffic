require 'minitest_helper'

class TestMarinetraffic < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Marinetraffic::VERSION
  end
end
