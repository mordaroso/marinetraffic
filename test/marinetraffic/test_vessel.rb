require 'minitest_helper'

module Marinetraffic
  class VesselTest < Minitest::Test
    def test_it_gives_back_a_single_vessel
      VCR.use_cassette('one_vessel') do
        vessel = Vessel.find("316001801")
        assert_equal Vessel, vessel.class
        assert_equal "316001801", vessel.mmsi
        assert_equal nil, vessel.ship_type
      end
    end

    def test_it_gives_back_a_single_vessel_with_extended_data
      VCR.use_cassette('one_extended_vessel') do
        vessel = Vessel.find("316001801", true)
        assert_equal Vessel, vessel.class
        assert_equal "316001801", vessel.mmsi
        assert_equal "70", vessel.ship_type
      end
    end
  end
end