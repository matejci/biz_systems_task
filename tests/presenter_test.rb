# frozen_string_literal: true

require 'minitest/autorun'
require './presenter'

class PresenterTest < Minitest::Test
  # bad scenarios
  begin
    def test_presenter_will_print_msg_if_wrong_type_is_passed
      presenter = Presenter.new(data: %w[1 2 3 4 5 6], type: 'all_visits')
      assert_output(/Wrong display type/) { presenter.display }
    end

    def test_presenter_will_return_nil_if_wrong_type_is_passed
      presenter = Presenter.new(data: %w[1 2 3 4 5 6], type: 'all_visits')
      assert_nil(presenter.display, nil)
    end
  end

  # happy scenarios
  begin
    def test_presenter_will_print_most_visited_if_correct_type_is_passed
      presenter = Presenter.new(data: %w[1 2 3 4 5 6], type: 'most_visited')
      assert_output(/Most visited/) { presenter.display }
    end

    def test_presenter_will_print_uniq_visits_if_correct_type_is_passed
      presenter = Presenter.new(data: %w[1 2 3 4 5 6], type: 'uniq_visits')
      assert_output(/Uniq visits/) { presenter.display }
    end
  end
end
