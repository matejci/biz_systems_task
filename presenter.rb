# frozen_string_literal: true

class Presenter
  def initialize(data:, type:)
    @data = data
    @type = type
  end

  def display
    send(@type)
  rescue NoMethodError => _e
    puts 'Wrong display type'
  end

  private

  def most_visited
    puts 'Most visited:'
    puts '-------------'
    puts @data
  end

  def uniq_visits
    puts 'Uniq visits:'
    puts '------------'
    puts @data
  end
end
