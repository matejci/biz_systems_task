# frozen_string_literal: true

module Services
  class SortService
    def initialize(hash)
      @hash = hash
    end

    def call
      sort if valid?
    end

    private

    def sort
      @hash.sort { |a, b| b[1] <=> a[1] }
    end

    def valid?
      @hash.is_a?(Hash)
    end
  end
end
