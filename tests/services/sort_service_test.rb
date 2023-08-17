# frozen_string_literal: true

require 'minitest/autorun'
require './services/sort_service'

class SortServiceTest < Minitest::Test
  # bad scenarios
  begin
    def test_will_return_nil_if_arg_is_nil
      service = Services::SortService.new(nil)
      assert_nil(service.call, nil)
    end

    def test_will_return_nil_if_arg_is_array
      service = Services::SortService.new([5, 3, 4, 1, 4, 11])
      assert_nil(service.call, nil)
    end

    def test_will_raise_error_if_argument_is_not_passed
      assert_raises ArgumentError do
        Services::SortService.new
      end
    end
  end

  # happy scenarios
  begin
    def test_will_sort_hash_by_values_desc
      unsorted_hash = {
        '/help_page/1' => 3,
        '/home' => 1,
        '/about' => 5,
        '/contact' => 2
      }

      sorted_array = [['/about', 5], ['/help_page/1', 3], ['/contact', 2], ['/home', 1]]

      service = Services::SortService.new(unsorted_hash)
      assert_equal(service.call, sorted_array)
    end

    def test_will_return_array
      unsorted_hash = {
        '/help_page/1' => 3,
        '/home' => 1,
        '/about' => 5,
        '/contact' => 2
      }

      service = Services::SortService.new(unsorted_hash)
      assert_instance_of(Array, service.call)
    end
  end
end
