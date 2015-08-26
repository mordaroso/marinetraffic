require File.expand_path('../../minitest_helper.rb', __FILE__)

module Marinetraffic
  class SubscriptionTest < Minitest::Test
    def test_it_gives_back_empty_vessels
      VCR.use_cassette('subscription_no_vessels') do
        subscription = Subscription.new(ENV['SUBSCRIPTION_KEY'])
        vessels = subscription.all
        assert_equal [], vessels
      end
    end

    def test_it_gives_back_a_single_vessel
      VCR.use_cassette('subscription_one_vessel') do
        subscription = Subscription.new(ENV['SUBSCRIPTION_KEY'])
        vessel = subscription.find('236111804', false, timespan: 60)
        assert_equal Vessel, vessel.class
        assert_equal "236111804", vessel.mmsi
        assert_equal 5, vessel.status
        assert_equal 'moored', vessel.status_human
        assert_equal nil, vessel.ship_type
      end
    end

    def test_it_gives_back_a_single_vessel_with_extended_data
      VCR.use_cassette('subscription_one_extended_vessel') do
        subscription = Subscription.new(ENV['SUBSCRIPTION_KEY'])
        vessels = subscription.all(true, timespan: 10)
        vessel = vessels.first
        assert_equal Vessel, vessel.class
        assert_equal "236111804", vessel.mmsi
        assert_equal 79, vessel.ship_type
        assert_equal 'Cargo', vessel.ship_type_human
      end
    end

    def test_it_gives_back_two_vessels
      VCR.use_cassette('subscription_two_vessel') do
        subscription = Subscription.new(ENV['SUBSCRIPTION_KEY'])
        vessels = subscription.all(false, timespan: 40)
        assert_equal vessels.size, 2
        assert_equal vessels.map(&:mmsi), ["236111804", "477197100"]
      end
    end
  end
end
