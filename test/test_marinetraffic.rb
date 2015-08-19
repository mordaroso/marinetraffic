require File.expand_path('../minitest_helper.rb', __FILE__)

class TestMarinetraffic < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Marinetraffic::VERSION
  end
end
