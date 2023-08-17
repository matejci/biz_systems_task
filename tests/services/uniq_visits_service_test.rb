# frozen_string_literal: true

require 'minitest/autorun'
require './services/uniq_visits_service'

class UniqVisitsServiceTest < Minitest::Test
  # bad scenarios
  begin
    def test_will_return_nil_if_arg_is_nil
      service = Services::UniqVisitsService.new(nil)
      assert_nil(service.call, nil)
    end

    def test_will_return_nil_if_arg_is_array
      service = Services::UniqVisitsService.new([])
      assert_nil(service.call, nil)
    end

    def test_will_raise_error_if_argument_is_not_passed
      assert_raises ArgumentError do
        Services::UniqVisitsService.new.call
      end
    end
  end

  # happy scenarios
  begin
    def test_will_return_number_of_uniq_values_per_key_for_hash
      unprocessed_hash = {
        '/help' => ['126.318.035.038', '184.123.665.067', '444.701.448.104', '061.945.150.735'],
        '/about' => ['061.945.150.735', '722.247.931.582', '061.945.150.735'],
        '/contact' => ['126.318.035.038', '184.123.665.067', '184.123.665.067', '061.945.150.735', '126.318.035.038']
      }

      processed_hash = {
        '/help' => 4,
        '/about' => 2,
        '/contact' => 3
      }

      service = Services::UniqVisitsService.new(unprocessed_hash)
      assert_equal(service.call, processed_hash)
    end
  end
end
