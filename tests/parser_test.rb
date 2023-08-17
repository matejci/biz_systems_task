# frozen_string_literal: true

require 'minitest/autorun'
require './parser'

class ParserTest < Minitest::Test
  # bad scenarios
  begin
    def test_parser_will_print_error_msg_if_file_path_is_wrong
      parser = Parser.new('path_to_file_which_does_not_exist')
      assert_output(/Error: No such file or directory @ rb_sysopen/) { parser.run }
    end

    def test_parser_will_print_error_msg_if_file_is_not_given
      parser = Parser.new(nil)
      assert_output(/Error:/) { parser.run }
    end

    def test_will_return_message_if_file_param_is_not_passed_to_app
      output = `ruby parser.rb`
      assert_match(/Missing file/, output)
    end
  end

  # happy scenarios
  begin
    def test_parser_will_return_array_of_two_arrays_if_file_is_parsed
      parser = Parser.new('webserver.log')
      results = parser.run
      assert_instance_of(Array, results.first)
      assert_instance_of(Array, results.last)
      assert_equal(results.size, 2)
    end

    def test_parser_will_return_array_if_file_is_parsed
      parser = Parser.new('webserver.log')
      assert_instance_of(Array, parser.run)
    end

    def test_app_will_return_most_visits_and_uniq_visits_text
      output = `ruby parser.rb webserver.log`
      assert_match(/Most visited/, output)
      assert_match(/Uniq visits/, output)
    end
  end
end
