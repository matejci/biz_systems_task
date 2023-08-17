# frozen_string_literal: true

require './services/most_visits_service'
require './services/sort_service'
require './services/uniq_visits_service'
require './presenter'

class Parser
  def initialize(file)
    @file = file
    @most_visits_hash = {}
    @uniq_hash = Hash.new { |h, k| h[k] = [] }
  end

  def run
    parse_file
    sort_most_visited
    process_uniq_visits
    sort_uniq_visits
    [@most_visits_results, @uniq_results]
  end

  private

  def parse_file
    File.open(@file, 'r').each do |line|
      key, value = line.split(' ')
      @most_visits_hash = Services::MostVisitsService.new(@most_visits_hash, key, value).call
      @uniq_hash[key] << value unless @uniq_hash[key].include?(value)
    end
  rescue StandardError => e
    puts "Error: #{e.message}"
  end

  def sort_most_visited
    @most_visits_results = Services::SortService.new(@most_visits_hash).call
  end

  def process_uniq_visits
    @uniq_results = Services::UniqVisitsService.new(@uniq_hash).call
  end

  def sort_uniq_visits
    @uniq_results = Services::SortService.new(@uniq_results).call
  end
end

file = ARGV[0]

if file.nil?
  puts 'Missing file'
else
  data = Parser.new(file).run

  return if data[0].empty? || data[1].empty?

  Presenter.new(data: data.first, type: 'most_visited').display
  puts '======================'
  Presenter.new(data: data.last, type: 'uniq_visits').display
end
