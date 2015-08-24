require File.expand_path('../../minitest_helper.rb', __FILE__)

module Marinetraffic
  class VesselTest < Minitest::Test
    def test_it_gives_back_a_single_vessel
      VCR.use_cassette('one_vessel') do
        vessel = Vessel.find("710013410")
        assert_equal Vessel, vessel.class
        assert_equal "710013410", vessel.mmsi
        assert_equal 0, vessel.status
        assert_equal 'under way using engine', vessel.status_human
        assert_equal nil, vessel.ship_type
      end
    end

    def test_it_gives_back_a_single_vessel_with_extended_data
      VCR.use_cassette('one_extended_vessel') do
        vessel = Vessel.find("710013410", true)
        assert_equal Vessel, vessel.class
        assert_equal "710013410", vessel.mmsi
        assert_equal 71, vessel.ship_type
        assert_equal 'Cargo', vessel.ship_type_human
      end
    end

    def test_it_gives_empty_response
      VCR.use_cassette('empty_vessel') do
        vessel = Vessel.find("236111804")
        assert_equal nil, vessel
      end
    end

    def test_it_throws_error_with_wrong_mmsi
      VCR.use_cassette('one_error_vessel') do
        assert_raises(Marinetraffic::MarinetrafficException) {
          Vessel.find("123")
        }
      end
    end
  end
end
