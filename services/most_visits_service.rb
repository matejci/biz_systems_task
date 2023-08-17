# frozen_string_literal: true

module Services
  class MostVisitsService
    def initialize(hash, key, value)
      @hash = hash
      @key = key
      @value = value
    end

    def call
      process
    end

    private

    def process
      @hash.key?(@key) ? (@hash[@key] = @hash[@key] += 1) : @hash[@key] = 1
      @hash
    end
  end
end
