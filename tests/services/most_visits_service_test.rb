# frozen_string_literal: true

require 'minitest/autorun'
require './services/most_visits_service'

class MostVisitsServiceTest < Minitest::Test
  # bad scenarios
  begin
    def test_will_raise_error_if_correct_number_of_arguments_are_not_passed
      assert_raises ArgumentError do
        Services::MostVisitsService.new({}, :key).call
      end

      assert_raises ArgumentError do
        Services::MostVisitsService.new(:key, :value).call
      end
    end

    def test_will_raise_error_if_first_parameter_is_not_hash
      assert_raises NoMethodError do
        Services::MostVisitsService.new([], :key, :value).call
      end

      assert_raises NoMethodError do
        Services::MostVisitsService.new(nil, :key, :value).call
      end
    end
  end

  # happy scenarios
  begin
    def test_will_return_number_of_visits_per_key_for_hash
      hash = {}
      data = ['/help_page/1 126.318.035.038',
              '/contact 184.123.665.067',
              '/home 184.123.665.067',
              '/about/2 444.701.448.104',
              '/help_page/1 929.398.951.889',
              '/help_page/1 722.247.931.582',
              '/about/2 061.945.150.735']

      service = Services::MostVisitsService.new(hash, data[0].split(' ').first, data[0].split(' ').last)
      assert_equal(service.call, '/help_page/1' => 1)

      service = Services::MostVisitsService.new(hash, data[1].split(' ').first, data[1].split(' ').last)
      assert_equal(service.call, '/help_page/1' => 1, '/contact' => 1)

      service = Services::MostVisitsService.new(hash, data[2].split(' ').first, data[2].split(' ').last)
      assert_equal(service.call, '/help_page/1' => 1, '/contact' => 1, '/home' => 1)

      service = Services::MostVisitsService.new(hash, data[3].split(' ').first, data[3].split(' ').last)
      assert_equal(service.call, '/help_page/1' => 1, '/contact' => 1, '/home' => 1, '/about/2' => 1)

      service = Services::MostVisitsService.new(hash, data[4].split(' ').first, data[4].split(' ').last)
      assert_equal(service.call, '/help_page/1' => 2, '/contact' => 1, '/home' => 1, '/about/2' => 1)

      service = Services::MostVisitsService.new(hash, data[5].split(' ').first, data[5].split(' ').last)
      assert_equal(service.call, '/help_page/1' => 3, '/contact' => 1, '/home' => 1, '/about/2' => 1)

      service = Services::MostVisitsService.new(hash, data[6].split(' ').first, data[6].split(' ').last)
      assert_equal(service.call, '/help_page/1' => 3, '/contact' => 1, '/home' => 1, '/about/2' => 2)
    end

    def test_will_return_correct_results_if_keys_and_values_are_nil
      hash = {}

      assert_equal(Services::MostVisitsService.new(hash, nil, nil).call, nil => 1)
      assert_equal(Services::MostVisitsService.new(hash, nil, nil).call, nil => 2)
      assert_equal(Services::MostVisitsService.new(hash, nil, nil).call, nil => 3)
      assert_equal(Services::MostVisitsService.new(hash, nil, nil).call, nil => 4)
      assert_equal(Services::MostVisitsService.new(hash, nil, nil).call, nil => 5)
    end
  end
end
